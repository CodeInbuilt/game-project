using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;

public class Player : MonoBehaviour
{

  public AudioClip hitSound;
  public AudioSource audioSource;
    public float moveSpeed = 5f;
     public GameObject enemyprefab;
     public float spawnInterval = 2f;
     public float enemyfallspeed = 3f;
     public TextMeshProUGUI gameovertext;
     private bool gameover = false;

    void Start()
    {
        InvokeRepeating(nameof(SpawnEnemy), 1f, spawnInterval);
        if(gameovertext != null)
         gameovertext.gameObject.SetActive(false);
            
        
    }
    void Update()
    {
        if(!gameover)
        {
            Moveplayer();
        }
        else
        {
            if(Input.GetKeyDown(KeyCode.R))
            {
                SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
            }
        }
    }
       
    void Moveplayer()
  {
    float move = Input.GetAxisRaw("Horizontal");
    transform.Translate(Vector2.right * move * moveSpeed * Time.deltaTime);
    Vector3 pos = transform.position;
    float screenwidth = Camera.main.orthographicSize * Camera.main.aspect;
    if(pos.x > screenwidth )
    {
        pos.x = -screenwidth;
    }
    else if(pos.x < -screenwidth)
    {
        pos.x = -screenwidth;
    }
    transform.position = pos;
  }
  void SpawnEnemy()
    {
        if(gameover) return;
        float screenwidth = Camera.main.orthographicSize * Camera.main.aspect;
        float randomX = Random.Range(-screenwidth, screenwidth);
        Vector3 spawnPosition = new Vector3(randomX, Camera.main.orthographicSize + 1f, 0f);
        GameObject enemy = Instantiate(enemyprefab, spawnPosition, Quaternion.identity);
        enemy.tag = "Enemy";
        EnemyMover mover = enemy.AddComponent<EnemyMover>();
        mover.speed = enemyfallspeed; 
    }
    private void OnTriggerEnter2D(Collider2D collision)
    {
        if(collision.CompareTag("Enemy"))
        {

                if(audioSource != null && hitSound != null)
                {
                    audioSource.PlayOneShot(hitSound);
                }



            gameover = true;
           CancelInvoke(nameof(SpawnEnemy));

           foreach( var m in FindObjectsByType<EnemyMover>(FindObjectsSortMode.None))
            m.enabled = false;
            if(gameovertext != null)
            {
                gameovertext.gameObject.SetActive(true);
                
            }
        }
    }
}  

public class EnemyMover : MonoBehaviour
{  
    public float speed = 2f;

    void Update()
    {
        transform.Translate(Vector2.down * speed * Time.deltaTime);
        if(transform.position.y < -Camera.main.orthographicSize - 1f)
        
            Destroy(gameObject);
        
    }       
        
}