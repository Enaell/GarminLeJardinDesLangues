import Toybox.Lang;

/**
 * VocabularyData
 * Module contenant le vocabulaire HSK 1 et HSK 2 (environ 300 mots)
 * Chaque entrée contient : hanzi, pinyin, traduction française, niveau HSK
 * 
 * Optimisation : Utilise des caches statiques pour accélérer les recherches
 */
class VocabularyData {
    
    // Structure : [hanzi, pinyin, traduction, hskLevel]
    private static var vocabulary as Array<Array> = [
        // HSK 1 - Niveau 1 (150 mots les plus courants)
        ["你好", "nǐ hǎo", "bonjour", 1],
        ["我", "wǒ", "je/moi", 1],
        ["你", "nǐ", "tu/toi", 1],
        ["他", "tā", "il/lui", 1],
        ["她", "tā", "elle", 1],
        ["们", "men", "pluriel", 1],
        ["是", "shì", "être", 1],
        ["的", "de", "de", 1],
        ["在", "zài", "être à/dans", 1],
        ["有", "yǒu", "avoir", 1],
        ["不", "bù", "ne pas", 1],
        ["这", "zhè", "ce/ceci", 1],
        ["那", "nà", "cela", 1],
        ["什么", "shénme", "quoi", 1],
        ["谁", "shuí", "qui", 1],
        ["哪", "nǎ", "quel/où", 1],
        ["里", "lǐ", "dans", 1],
        ["个", "gè", "classificateur", 1],
        ["人", "rén", "personne", 1],
        ["家", "jiā", "maison/famille", 1],
        ["水", "shuǐ", "eau", 1],
        ["火", "huǒ", "feu", 1],
        ["天", "tiān", "jour/ciel", 1],
        ["大", "dà", "grand", 1],
        ["小", "xiǎo", "petit", 1],
        ["多", "duō", "beaucoup", 1],
        ["少", "shǎo", "peu", 1],
        ["好", "hǎo", "bon/bien", 1],
        ["很", "hěn", "très", 1],
        ["都", "dōu", "tous", 1],
        ["也", "yě", "aussi", 1],
        ["吗", "ma", "particule interrogative", 1],
        ["呢", "ne", "et", 1],
        ["吧", "ba", "suggestion", 1],
        ["一", "yī", "un", 1],
        ["二", "èr", "deux", 1],
        ["三", "sān", "trois", 1],
        ["四", "sì", "quatre", 1],
        ["五", "wǔ", "cinq", 1],
        ["六", "liù", "six", 1],
        ["七", "qī", "sept", 1],
        ["八", "bā", "huit", 1],
        ["九", "jiǔ", "neuf", 1],
        ["十", "shí", "dix", 1],
        ["零", "líng", "zéro", 1],
        ["岁", "suì", "ans (âge)", 1],
        ["年", "nián", "année", 1],
        ["月", "yuè", "mois", 1],
        ["日", "rì", "jour", 1],
        ["星期", "xīngqī", "semaine", 1],
        ["今天", "jīntiān", "aujourd'hui", 1],
        ["明天", "míngtiān", "demain", 1],
        ["昨天", "zuótiān", "hier", 1],
        ["上午", "shàngwǔ", "matin", 1],
        ["下午", "xiàwǔ", "après-midi", 1],
        ["中午", "zhōngwǔ", "midi", 1],
        ["现在", "xiànzài", "maintenant", 1],
        ["时候", "shíhou", "moment", 1],
        ["点", "diǎn", "heure", 1],
        ["分", "fēn", "minute", 1],
        ["半", "bàn", "demi", 1],
        ["先生", "xiānsheng", "monsieur", 1],
        ["小姐", "xiǎojiě", "mademoiselle", 1],
        ["太太", "tàitai", "madame", 1],
        ["爸爸", "bàba", "papa", 1],
        ["妈妈", "māma", "maman", 1],
        ["儿子", "érzi", "fils", 1],
        ["女儿", "nǚ'ér", "fille", 1],
        ["老师", "lǎoshī", "professeur", 1],
        ["学生", "xuésheng", "étudiant", 1],
        ["同学", "tóngxué", "camarade", 1],
        ["朋友", "péngyou", "ami", 1],
        ["医生", "yīshēng", "médecin", 1],
        ["名字", "míngzi", "nom", 1],
        ["国", "guó", "pays", 1],
        ["中国", "Zhōngguó", "Chine", 1],
        ["北京", "Běijīng", "Pékin", 1],
        ["法国", "Fǎguó", "France", 1],
        ["美国", "Měiguó", "États-Unis", 1],
        ["英国", "Yīngguó", "Angleterre", 1],
        ["学校", "xuéxiào", "école", 1],
        ["汉语", "Hànyǔ", "chinois (langue)", 1],
        ["字", "zì", "caractère", 1],
        ["桌子", "zhuōzi", "table", 1],
        ["椅子", "yǐzi", "chaise", 1],
        ["书", "shū", "livre", 1],
        ["本", "běn", "classificateur livres", 1],
        ["电视", "diànshì", "télévision", 1],
        ["电脑", "diànnǎo", "ordinateur", 1],
        ["电影", "diànyǐng", "film", 1],
        ["电话", "diànhuà", "téléphone", 1],
        ["手机", "shǒujī", "portable", 1],
        ["商店", "shāngdiàn", "magasin", 1],
        ["饭店", "fàndiàn", "restaurant", 1],
        ["饭", "fàn", "riz/repas", 1],
        ["面包", "miànbāo", "pain", 1],
        ["茶", "chá", "thé", 1],
        ["杯子", "bēizi", "tasse", 1],
        ["钱", "qián", "argent", 1],
        ["块", "kuài", "yuan (monnaie)", 1],
        ["衣服", "yīfu", "vêtements", 1],
        ["件", "jiàn", "classificateur vêtements", 1],
        ["上", "shàng", "sur/dessus", 1],
        ["下", "xià", "sous/dessous", 1],
        ["前", "qián", "devant", 1],
        ["后", "hòu", "derrière", 1],
        ["里面", "lǐmiàn", "dedans", 1],
        ["外面", "wàimiàn", "dehors", 1],
        ["东西", "dōngxi", "chose", 1],
        ["猫", "māo", "chat", 1],
        ["狗", "gǒu", "chien", 1],
        ["苹果", "píngguǒ", "pomme", 1],
        ["菜", "cài", "légumes/plat", 1],
        ["米饭", "mǐfàn", "riz cuit", 1],
        ["来", "lái", "venir", 1],
        ["去", "qù", "aller", 1],
        ["回", "huí", "retourner", 1],
        ["看", "kàn", "regarder", 1],
        ["见", "jiàn", "voir/rencontrer", 1],
        ["听", "tīng", "écouter", 1],
        ["说", "shuō", "parler/dire", 1],
        ["读", "dú", "lire", 1],
        ["写", "xiě", "écrire", 1],
        ["买", "mǎi", "acheter", 1],
        ["卖", "mài", "vendre", 1],
        ["开", "kāi", "ouvrir", 1],
        ["坐", "zuò", "s'asseoir", 1],
        ["住", "zhù", "habiter", 1],
        ["吃", "chī", "manger", 1],
        ["喝", "hē", "boire", 1],
        ["睡觉", "shuìjiào", "dormir", 1],
        ["打电话", "dǎ diànhuà", "téléphoner", 1],
        ["做", "zuò", "faire", 1],
        ["工作", "gōngzuò", "travailler", 1],
        ["学习", "xuéxí", "étudier", 1],
        ["喜欢", "xǐhuan", "aimer", 1],
        ["想", "xiǎng", "vouloir/penser", 1],
        ["认识", "rènshi", "connaître", 1],
        ["会", "huì", "savoir faire", 1],
        ["能", "néng", "pouvoir", 1],
        ["可以", "kěyǐ", "pouvoir/permis", 1],
        ["对不起", "duìbuqǐ", "pardon", 1],
        ["没关系", "méi guānxi", "pas grave", 1],
        ["谢谢", "xièxie", "merci", 1],
        ["不客气", "bú kèqi", "de rien", 1],
        ["再见", "zàijiàn", "au revoir", 1],
        ["请", "qǐng", "s'il vous plaît", 1],
        ["叫", "jiào", "appeler", 1],
        ["怎么", "zěnme", "comment", 1],
        ["怎么样", "zěnmeyàng", "comment ça va", 1],
        ["多少", "duōshao", "combien", 1],
        ["几", "jǐ", "combien (petit)", 1],
        ["冷", "lěng", "froid", 1],
        ["热", "rè", "chaud", 1],
        
        // HSK 2 - Niveau 2 (150 mots supplémentaires)
        ["爱", "ài", "aimer", 2],
        ["吧", "ba", "suggestion", 2],
        ["白", "bái", "blanc", 2],
        ["百", "bǎi", "cent", 2],
        ["帮助", "bāngzhù", "aider", 2],
        ["报纸", "bàozhǐ", "journal", 2],
        ["比", "bǐ", "comparer", 2],
        ["别", "bié", "ne pas", 2],
        ["宾馆", "bīnguǎn", "hôtel", 2],
        ["长", "cháng", "long", 2],
        ["唱歌", "chànggē", "chanter", 2],
        ["出", "chū", "sortir", 2],
        ["穿", "chuān", "porter (vêtements)", 2],
        ["船", "chuán", "bateau", 2],
        ["次", "cì", "fois", 2],
        ["从", "cóng", "depuis", 2],
        ["错", "cuò", "faux/erreur", 2],
        ["打篮球", "dǎ lánqiú", "jouer au basket", 2],
        ["弟弟", "dìdi", "petit frère", 2],
        ["第一", "dì-yī", "premier", 2],
        ["懂", "dǒng", "comprendre", 2],
        ["对", "duì", "correct", 2],
        ["房间", "fángjiān", "chambre", 2],
        ["非常", "fēicháng", "très", 2],
        ["服务员", "fúwùyuán", "serveur", 2],
        ["高", "gāo", "haut/grand", 2],
        ["告诉", "gàosu", "dire/informer", 2],
        ["哥哥", "gēge", "grand frère", 2],
        ["给", "gěi", "donner", 2],
        ["公共汽车", "gōnggòng qìchē", "bus", 2],
        ["公司", "gōngsī", "entreprise", 2],
        ["贵", "guì", "cher", 2],
        ["过", "guò", "passer/expérience", 2],
        ["孩子", "háizi", "enfant", 2],
        ["还", "hái", "encore", 2],
        ["黑", "hēi", "noir", 2],
        ["红", "hóng", "rouge", 2],
        ["欢迎", "huānyíng", "bienvenue", 2],
        ["回答", "huídá", "répondre", 2],
        ["机场", "jīchǎng", "aéroport", 2],
        ["鸡蛋", "jīdàn", "œuf", 2],
        ["几乎", "jīhū", "presque", 2],
        ["记得", "jìde", "se souvenir", 2],
        ["件", "jiàn", "affaire/pièce", 2],
        ["教室", "jiàoshì", "salle de classe", 2],
        ["姐姐", "jiějie", "grande sœur", 2],
        ["介绍", "jièshào", "présenter", 2],
        ["近", "jìn", "proche", 2],
        ["进", "jìn", "entrer", 2],
        ["就", "jiù", "alors/justement", 2],
        ["觉得", "juéde", "trouver/sentir", 2],
        ["咖啡", "kāfēi", "café", 2],
        ["开始", "kāishǐ", "commencer", 2],
        ["考试", "kǎoshì", "examen", 2],
        ["课", "kè", "cours", 2],
        ["快", "kuài", "rapide", 2],
        ["快乐", "kuàilè", "joyeux", 2],
        ["累", "lèi", "fatigué", 2],
        ["离", "lí", "distance de", 2],
        ["两", "liǎng", "deux (avec class.)", 2],
        ["路", "lù", "route", 2],
        ["旅游", "lǚyóu", "voyager", 2],
        ["卖", "mài", "vendre", 2],
        ["慢", "màn", "lent", 2],
        ["忙", "máng", "occupé", 2],
        ["每", "měi", "chaque", 2],
        ["妹妹", "mèimei", "petite sœur", 2],
        ["门", "mén", "porte", 2],
        ["面条", "miàntiáo", "nouilles", 2],
        ["男人", "nánrén", "homme", 2],
        ["您", "nín", "vous (poli)", 2],
        ["牛奶", "niúnǎi", "lait", 2],
        ["女人", "nǚrén", "femme", 2],
        ["旁边", "pángbiān", "à côté", 2],
        ["跑步", "pǎobù", "courir", 2],
        ["便宜", "piányi", "bon marché", 2],
        ["漂亮", "piàoliang", "beau/joli", 2],
        ["妻子", "qīzi", "épouse", 2],
        ["起床", "qǐchuáng", "se lever", 2],
        ["千", "qiān", "mille", 2],
        ["铅笔", "qiānbǐ", "crayon", 2],
        ["晴", "qíng", "beau temps", 2],
        ["让", "ràng", "laisser/faire", 2],
        ["日", "rì", "soleil/jour", 2],
        ["上班", "shàngbān", "aller au travail", 2],
        ["身体", "shēntǐ", "corps", 2],
        ["生病", "shēngbìng", "être malade", 2],
        ["生日", "shēngrì", "anniversaire", 2],
        ["时间", "shíjiān", "temps", 2],
        ["事情", "shìqing", "affaire/chose", 2],
        ["手表", "shǒubiǎo", "montre", 2],
        ["售货员", "shòuhuòyuán", "vendeur", 2],
        ["树", "shù", "arbre", 2],
        ["数学", "shùxué", "mathématiques", 2],
        ["送", "sòng", "offrir/envoyer", 2],
        ["虽然", "suīrán", "bien que", 2],
        ["所以", "suǒyǐ", "donc", 2],
        ["它", "tā", "il/elle (chose)", 2],
        ["踢足球", "tī zúqiú", "jouer au foot", 2],
        ["题", "tí", "question/sujet", 2],
        ["跳舞", "tiàowǔ", "danser", 2],
        ["外", "wài", "extérieur", 2],
        ["完", "wán", "finir", 2],
        ["玩", "wán", "jouer/s'amuser", 2],
        ["晚上", "wǎnshang", "soir", 2],
        ["往", "wǎng", "vers", 2],
        ["为什么", "wèishénme", "pourquoi", 2],
        ["问", "wèn", "demander", 2],
        ["问题", "wèntí", "problème/question", 2],
        ["西瓜", "xīguā", "pastèque", 2],
        ["希望", "xīwàng", "espérer", 2],
        ["洗", "xǐ", "laver", 2],
        ["小时", "xiǎoshí", "heure", 2],
        ["笑", "xiào", "rire", 2],
        ["新", "xīn", "nouveau", 2],
        ["姓", "xìng", "nom de famille", 2],
        ["休息", "xiūxi", "se reposer", 2],
        ["雪", "xuě", "neige", 2],
        ["颜色", "yánsè", "couleur", 2],
        ["眼睛", "yǎnjing", "yeux", 2],
        ["羊肉", "yángròu", "mouton", 2],
        ["药", "yào", "médicament", 2],
        ["要", "yào", "vouloir", 2],
        ["爷爷", "yéye", "grand-père paternel", 2],
        ["一起", "yìqǐ", "ensemble", 2],
        ["已经", "yǐjīng", "déjà", 2],
        ["意思", "yìsi", "signification", 2],
        ["阴", "yīn", "nuageux", 2],
        ["因为", "yīnwèi", "parce que", 2],
        ["游泳", "yóuyǒng", "nager", 2],
        ["右边", "yòubiān", "droite", 2],
        ["鱼", "yú", "poisson", 2],
        ["元", "yuán", "yuan (monnaie)", 2],
        ["远", "yuǎn", "loin", 2],
        ["运动", "yùndòng", "sport", 2],
        ["再", "zài", "encore/de nouveau", 2],
        ["早上", "zǎoshang", "matin", 2],
        ["丈夫", "zhàngfu", "mari", 2],
        ["找", "zhǎo", "chercher", 2],
        ["着", "zhe", "particule durative", 2],
        ["真", "zhēn", "vraiment", 2],
        ["正在", "zhèngzài", "être en train de", 2],
        ["知道", "zhīdào", "savoir", 2],
        ["准备", "zhǔnbèi", "préparer", 2],
        ["走", "zǒu", "marcher", 2],
        ["最", "zuì", "le plus", 2],
        ["左边", "zuǒbiān", "gauche", 2],
        
        // HSK 3 - Niveau 3 (300 mots supplémentaires)
        ["阿姨", "āyí", "tante", 3],
        ["啊", "a", "particule", 3],
        ["矮", "ǎi", "petit/court", 3],
        ["爱好", "àihào", "passe-temps", 3],
        ["安静", "ānjìng", "calme", 3],
        ["把", "bǎ", "particule", 3],
        ["搬", "bān", "déménager", 3],
        ["班", "bān", "classe", 3],
        ["办法", "bànfǎ", "méthode", 3],
        ["办公室", "bàngōngshì", "bureau", 3],
        ["半", "bàn", "moitié", 3],
        ["帮忙", "bāngmáng", "aider", 3],
        ["包", "bāo", "sac", 3],
        ["饱", "bǎo", "rassasié", 3],
        ["北方", "běifāng", "nord", 3],
        ["被", "bèi", "par (passif)", 3],
        ["鼻子", "bízi", "nez", 3],
        ["比较", "bǐjiào", "comparer", 3],
        ["比赛", "bǐsài", "compétition", 3],
        ["必须", "bìxū", "devoir", 3],
        ["变化", "biànhuà", "changement", 3],
        ["表示", "biǎoshì", "exprimer", 3],
        ["表演", "biǎoyǎn", "spectacle", 3],
        ["别人", "biéren", "les autres", 3],
        ["宾馆", "bīnguǎn", "hôtel", 3],
        ["冰箱", "bīngxiāng", "réfrigérateur", 3],
        ["不但", "búdàn", "non seulement", 3],
        ["不过", "búguò", "mais", 3],
        ["才", "cái", "seulement", 3],
        ["菜单", "càidān", "menu", 3],
        ["参加", "cānjiā", "participer", 3],
        ["草", "cǎo", "herbe", 3],
        ["层", "céng", "étage", 3],
        ["差", "chà", "manquer", 3],
        ["超市", "chāoshì", "supermarché", 3],
        ["衬衫", "chènshān", "chemise", 3],
        ["成绩", "chéngjī", "résultats", 3],
        ["城市", "chéngshì", "ville", 3],
        ["迟到", "chídào", "être en retard", 3],
        ["除了", "chúle", "sauf", 3],
        ["厨房", "chúfáng", "cuisine", 3],
        ["穿", "chuān", "porter", 3],
        ["窗户", "chuānghu", "fenêtre", 3],
        ["春", "chūn", "printemps", 3],
        ["词典", "cídiǎn", "dictionnaire", 3],
        ["词语", "cíyǔ", "mot", 3],
        ["聪明", "cōngming", "intelligent", 3],
        ["打扫", "dǎsǎo", "nettoyer", 3],
        ["打算", "dǎsuàn", "projeter", 3],
        ["带", "dài", "apporter", 3],
        ["担心", "dānxīn", "s'inquiéter", 3],
        ["蛋糕", "dàngāo", "gâteau", 3],
        ["当然", "dāngrán", "bien sûr", 3],
        ["到", "dào", "arriver", 3],
        ["灯", "dēng", "lampe", 3],
        ["等", "děng", "attendre", 3],
        ["低", "dī", "bas", 3],
        ["地方", "dìfang", "endroit", 3],
        ["地铁", "dìtiě", "métro", 3],
        ["地图", "dìtú", "carte", 3],
        ["电梯", "diàntī", "ascenseur", 3],
        ["电子邮件", "diànzǐ yóujiàn", "email", 3],
        ["东", "dōng", "est", 3],
        ["冬", "dōng", "hiver", 3],
        ["动物", "dòngwù", "animal", 3],
        ["短", "duǎn", "court", 3],
        ["段", "duàn", "section", 3],
        ["锻炼", "duànliàn", "exercice", 3],
        ["多么", "duōme", "combien", 3],
        ["饿", "è", "avoir faim", 3],
        ["而且", "érqiě", "et aussi", 3],
        ["耳朵", "ěrduo", "oreille", 3],
        ["发", "fā", "envoyer", 3],
        ["发烧", "fāshāo", "avoir de la fièvre", 3],
        ["发现", "fāxiàn", "découvrir", 3],
        ["方便", "fāngbiàn", "pratique", 3],
        ["方法", "fāngfǎ", "méthode", 3],
        ["方向", "fāngxiàng", "direction", 3],
        ["放", "fàng", "mettre", 3],
        ["放心", "fàngxīn", "être rassuré", 3],
        ["放暑假", "fàng shǔjià", "vacances d'été", 3],
        ["分", "fēn", "diviser", 3],
        ["附近", "fùjìn", "à proximité", 3],
        ["复习", "fùxí", "réviser", 3],
        ["干净", "gānjìng", "propre", 3],
        ["敢", "gǎn", "oser", 3],
        ["感冒", "gǎnmào", "rhume", 3],
        ["感觉", "gǎnjué", "sentiment", 3],
        ["刚", "gāng", "juste", 3],
        ["刚才", "gāngcái", "tout à l'heure", 3],
        ["根据", "gēnjù", "selon", 3],
        ["更", "gèng", "encore plus", 3],
        ["公斤", "gōngjīn", "kilogramme", 3],
        ["公园", "gōngyuán", "parc", 3],
        ["故事", "gùshi", "histoire", 3],
        ["刮风", "guā fēng", "vent", 3],
        ["关", "guān", "fermer", 3],
        ["关系", "guānxi", "relation", 3],
        ["关心", "guānxīn", "se soucier", 3],
        ["关于", "guānyú", "concernant", 3],
        ["观众", "guānzhòng", "public", 3],
        ["国家", "guójiā", "pays", 3],
        ["果汁", "guǒzhī", "jus de fruit", 3],
        ["过去", "guòqù", "passé", 3],
        ["害怕", "hàipà", "avoir peur", 3],
        ["寒假", "hánjià", "vacances d'hiver", 3],
        ["汉字", "Hànzì", "caractère chinois", 3],
        ["好吃", "hǎochī", "délicieux", 3],
        ["好像", "hǎoxiàng", "sembler", 3],
        ["号", "hào", "numéro", 3],
        ["号码", "hàomǎ", "numéro", 3],
        ["合适", "héshì", "approprié", 3],
        ["河", "hé", "rivière", 3],
        ["黑板", "hēibǎn", "tableau noir", 3],
        ["后来", "hòulái", "plus tard", 3],
        ["护照", "hùzhào", "passeport", 3],
        ["花", "huā", "fleur", 3],
        ["花园", "huāyuán", "jardin", 3],
        ["画", "huà", "dessiner", 3],
        ["坏", "huài", "mauvais", 3],
        ["环境", "huánjìng", "environnement", 3],
        ["换", "huàn", "changer", 3],
        ["黄", "huáng", "jaune", 3],
        ["回", "huí", "retourner", 3],
        ["会议", "huìyì", "réunion", 3],
        ["或者", "huòzhě", "ou", 3],
        ["几乎", "jīhū", "presque", 3],
        ["机会", "jīhuì", "opportunité", 3],
        ["极", "jí", "extrêmement", 3],
        ["记得", "jìde", "se souvenir", 3],
        ["季节", "jìjié", "saison", 3],
        ["检查", "jiǎnchá", "vérifier", 3],
        ["简单", "jiǎndān", "simple", 3],
        ["见面", "jiànmiàn", "se rencontrer", 3],
        ["健康", "jiànkāng", "santé", 3],
        ["讲", "jiǎng", "parler", 3],
        ["教", "jiāo", "enseigner", 3],
        ["角", "jiǎo", "coin", 3],
        ["脚", "jiǎo", "pied", 3],
        ["接", "jiē", "recevoir", 3],
        ["街道", "jiēdào", "rue", 3],
        ["节目", "jiémù", "programme", 3],
        ["节日", "jiérì", "fête", 3],
        ["结婚", "jiéhūn", "se marier", 3],
        ["结束", "jiéshù", "finir", 3],
        ["解决", "jiějué", "résoudre", 3],
        ["借", "jiè", "emprunter", 3],
        ["金", "jīn", "or", 3],
        ["经常", "jīngcháng", "souvent", 3],
        ["经过", "jīngguò", "passer par", 3],
        ["经理", "jīnglǐ", "directeur", 3],
        ["久", "jiǔ", "longtemps", 3],
        ["旧", "jiù", "vieux", 3],
        ["举办", "jǔbàn", "organiser", 3],
        ["句子", "jùzi", "phrase", 3],
        ["决定", "juédìng", "décider", 3],
        ["可爱", "kě'ài", "mignon", 3],
        ["可能", "kěnéng", "possible", 3],
        ["渴", "kě", "avoir soif", 3],
        ["刻", "kè", "quart d'heure", 3],
        ["客人", "kèren", "invité", 3],
        ["空调", "kōngtiáo", "climatisation", 3],
        ["口", "kǒu", "bouche", 3],
        ["哭", "kū", "pleurer", 3],
        ["裤子", "kùzi", "pantalon", 3],
        ["筷子", "kuàizi", "baguettes", 3],
        ["蓝", "lán", "bleu", 3],
        ["老", "lǎo", "vieux", 3],
        ["姥姥", "lǎolao", "grand-mère maternelle", 3],
        ["礼物", "lǐwù", "cadeau", 3],
        ["历史", "lìshǐ", "histoire", 3],
        ["脸", "liǎn", "visage", 3],
        ["练习", "liànxí", "pratiquer", 3],
        ["辆", "liàng", "classificateur véhicule", 3],
        ["了解", "liǎojiě", "comprendre", 3],
        ["邻居", "línjū", "voisin", 3],
        ["楼", "lóu", "immeuble", 3],
        ["绿", "lǜ", "vert", 3],
        ["满意", "mǎnyì", "satisfait", 3],
        ["帽子", "màozi", "chapeau", 3],
        ["米", "mǐ", "mètre", 3],
        ["面包", "miànbāo", "pain", 3],
        ["明白", "míngbai", "comprendre", 3],
        ["拿", "ná", "prendre", 3],
        ["奶奶", "nǎinai", "grand-mère paternelle", 3],
        ["南", "nán", "sud", 3],
        ["南方", "nánfāng", "sud", 3],
        ["难", "nán", "difficile", 3],
        ["难过", "nánguò", "triste", 3],
        ["年级", "niánjí", "année scolaire", 3],
        ["年轻", "niánqīng", "jeune", 3],
        ["鸟", "niǎo", "oiseau", 3],
        ["努力", "nǔlì", "s'efforcer", 3],
        ["爬山", "pá shān", "faire de la randonnée", 3],
        ["盘子", "pánzi", "assiette", 3],
        ["胖", "pàng", "gros", 3],
        ["皮鞋", "píxié", "chaussures en cuir", 3],
        ["啤酒", "píjiǔ", "bière", 3],
        ["葡萄", "pútao", "raisin", 3],
        ["普通话", "pǔtōnghuà", "mandarin", 3],
        ["其实", "qíshí", "en fait", 3],
        ["其他", "qítā", "autre", 3],
        ["奇怪", "qíguài", "étrange", 3],
        ["骑", "qí", "monter (vélo)", 3],
        ["清楚", "qīngchu", "clair", 3],
        ["秋", "qiū", "automne", 3],
        ["裙子", "qúnzi", "jupe", 3],
        ["然后", "ránhòu", "ensuite", 3],
        ["热情", "rèqíng", "enthousiaste", 3],
        ["认为", "rènwéi", "penser", 3],
        ["认真", "rènzhēn", "sérieux", 3],
        ["容易", "róngyì", "facile", 3],
        ["如果", "rúguǒ", "si", 3],
        ["伞", "sǎn", "parapluie", 3],
        ["上网", "shàngwǎng", "aller sur internet", 3],
        ["生气", "shēngqì", "être en colère", 3],
        ["声音", "shēngyīn", "son/voix", 3],
        ["世界", "shìjiè", "monde", 3],
        ["试", "shì", "essayer", 3],
        ["瘦", "shòu", "maigre", 3],
        ["舒服", "shūfu", "confortable", 3],
        ["叔叔", "shūshu", "oncle", 3],
        ["数", "shù", "nombre", 3],
        ["刷牙", "shuā yá", "se brosser les dents", 3],
        ["双", "shuāng", "paire", 3],
        ["水平", "shuǐpíng", "niveau", 3],
        ["司机", "sījī", "chauffeur", 3],
        ["死", "sǐ", "mourir", 3],
        ["太阳", "tàiyáng", "soleil", 3],
        ["糖", "táng", "sucre", 3],
        ["特别", "tèbié", "spécial", 3],
        ["疼", "téng", "douleur", 3],
        ["提高", "tígāo", "améliorer", 3],
        ["体育", "tǐyù", "sport", 3],
        ["甜", "tián", "sucré", 3],
        ["条", "tiáo", "classificateur", 3],
        ["同事", "tóngshì", "collègue", 3],
        ["同意", "tóngyì", "être d'accord", 3],
        ["头发", "tóufa", "cheveux", 3],
        ["突然", "tūrán", "soudain", 3],
        ["图书馆", "túshūguǎn", "bibliothèque", 3],
        ["腿", "tuǐ", "jambe", 3],
        ["完成", "wánchéng", "terminer", 3],
        ["碗", "wǎn", "bol", 3],
        ["万", "wàn", "dix mille", 3],
        ["忘记", "wàngjì", "oublier", 3],
        ["为", "wèi", "pour", 3],
        ["为了", "wèile", "afin de", 3],
        ["位", "wèi", "classificateur poli", 3],
        ["文化", "wénhuà", "culture", 3],
        ["西", "xī", "ouest", 3],
        ["西方", "xīfāng", "occident", 3],
        ["习惯", "xíguàn", "habitude", 3],
        ["洗手间", "xǐshǒujiān", "toilettes", 3],
        ["洗澡", "xǐzǎo", "se laver", 3],
        ["夏", "xià", "été", 3],
        ["先", "xiān", "d'abord", 3],
        ["香蕉", "xiāngjiāo", "banane", 3],
        ["相同", "xiāngtóng", "identique", 3],
        ["相信", "xiāngxìn", "croire", 3],
        ["像", "xiàng", "ressembler", 3],
        ["向", "xiàng", "vers", 3],
        ["小心", "xiǎoxīn", "faire attention", 3],
        ["校长", "xiàozhǎng", "directeur d'école", 3],
        ["鞋", "xié", "chaussure", 3],
        ["些", "xiē", "quelques", 3],
        ["心情", "xīnqíng", "humeur", 3],
        ["信", "xìn", "lettre", 3],
        ["信用卡", "xìnyòngkǎ", "carte de crédit", 3],
        ["星期", "xīngqī", "semaine", 3],
        ["行", "xíng", "aller/marcher", 3],
        ["行李箱", "xínglixiāng", "valise", 3],
        ["醒", "xǐng", "se réveiller", 3],
        ["兴趣", "xìngqù", "intérêt", 3],
        ["熊猫", "xióngmāo", "panda", 3],
        ["需要", "xūyào", "avoir besoin", 3],
        ["选择", "xuǎnzé", "choisir", 3],
        ["要求", "yāoqiú", "exiger", 3],
        ["爷爷", "yéye", "grand-père", 3],
        ["一定", "yídìng", "certainement", 3],
        ["一共", "yígòng", "au total", 3],
        ["一会儿", "yíhuìr", "un moment", 3],
        ["一样", "yíyàng", "pareil", 3],
        ["一般", "yìbān", "ordinaire", 3],
        ["一边", "yìbiān", "en même temps", 3],
        ["一直", "yìzhí", "toujours", 3],
        ["以后", "yǐhòu", "après", 3],
        ["以前", "yǐqián", "avant", 3],
        ["以为", "yǐwéi", "penser/croire", 3],
        ["音乐", "yīnyuè", "musique", 3],
        ["银行", "yínháng", "banque", 3],
        ["应该", "yīnggāi", "devoir", 3],
        ["影响", "yǐngxiǎng", "influence", 3],
        ["用", "yòng", "utiliser", 3],
        ["优秀", "yōuxiù", "excellent", 3],
        ["尤其", "yóuqí", "surtout", 3],
        ["有名", "yǒumíng", "célèbre", 3],
        ["又", "yòu", "encore", 3],
        ["遇到", "yùdào", "rencontrer", 3],
        ["月亮", "yuèliang", "lune", 3],
        ["云", "yún", "nuage", 3],
        ["允许", "yǔnxǔ", "permettre", 3],
        ["杂志", "zázhì", "magazine", 3],
        ["咱们", "zánmen", "nous", 3],
        ["脏", "zāng", "sale", 3],
        ["糟糕", "zāogāo", "terrible", 3],
        ["照顾", "zhàogù", "prendre soin", 3],
        ["照片", "zhàopiàn", "photo", 3],
        ["照相机", "zhàoxiàngjī", "appareil photo", 3],
        ["只", "zhǐ", "seulement", 3],
        ["只有", "zhǐyǒu", "seulement", 3],
        ["中间", "zhōngjiān", "milieu", 3],
        ["终于", "zhōngyú", "finalement", 3],
        ["种", "zhǒng", "sorte", 3],
        ["重要", "zhòngyào", "important", 3],
        ["周末", "zhōumò", "week-end", 3],
        ["主要", "zhǔyào", "principal", 3],
        ["注意", "zhùyì", "faire attention", 3],
        ["自己", "zìjǐ", "soi-même", 3],
        ["自行车", "zìxíngchē", "vélo", 3],
        ["总是", "zǒngshì", "toujours", 3],
        ["嘴", "zuǐ", "bouche", 3],
        ["作业", "zuòyè", "devoirs", 3],
        ["作用", "zuòyòng", "rôle", 3]
    ];
    
    // ========== CACHES D'OPTIMISATION ==========
    
    // Cache par niveau HSK (contient les indices des mots)
    private static var hsk1Indices as Array<Number> or Null = null;
    private static var hsk2Indices as Array<Number> or Null = null;
    private static var hsk3Indices as Array<Number> or Null = null;
    
    // Cache par statut (contient les indices des mots)
    private static var noStatusIndices as Array<Number> or Null = null;
    private static var unknownIndices as Array<Number> or Null = null;
    private static var knownIndices as Array<Number> or Null = null;
    private static var masteredIndices as Array<Number> or Null = null;
    
    // Flag pour savoir si les caches sont initialisés
    private static var cachesInitialized as Boolean = false;

    /**
     * Initialise tous les caches (appelé au démarrage de l'application)
     */
    static function initializeCaches() as Void {
        if (cachesInitialized) {
            return; // Déjà initialisé
        }
        
        // Initialiser les caches HSK
        hsk1Indices = [] as Array<Number>;
        hsk2Indices = [] as Array<Number>;
        hsk3Indices = [] as Array<Number>;
        
        // Parcourir une seule fois le vocabulaire pour remplir les caches HSK
        for (var i = 0; i < vocabulary.size(); i++) {
            var level = vocabulary[i][3] as Number;
            
            if (level == 1) {
                hsk1Indices.add(i);
            } else if (level == 2) {
                hsk2Indices.add(i);
            } else if (level == 3) {
                hsk3Indices.add(i);
            }
        }
        
        // Initialiser les caches de statuts
        refreshStatusCaches();
        
        cachesInitialized = true;
    }
    
    /**
     * Rafraîchit les caches de statuts (appelé au démarrage et après chaque changement)
     */
    static function refreshStatusCaches() as Void {
        noStatusIndices = [] as Array<Number>;
        unknownIndices = [] as Array<Number>;
        knownIndices = [] as Array<Number>;
        masteredIndices = [] as Array<Number>;
        
        for (var i = 0; i < vocabulary.size(); i++) {
            if (!WordProgressStorage.hasStatus(i)) {
                noStatusIndices.add(i);
            } else {
                var status = WordProgressStorage.getWordStatus(i);
                
                if (status == WordProgressStorage.STATUS_UNKNOWN) {
                    unknownIndices.add(i);
                } else if (status == WordProgressStorage.STATUS_KNOWN) {
                    knownIndices.add(i);
                } else if (status == WordProgressStorage.STATUS_MASTERED) {
                    masteredIndices.add(i);
                }
            }
        }
    }
    
    /**
     * Met à jour les caches de statuts après un changement de statut
     * @param wordIndex Index du mot modifié
     * @param oldStatus Ancien statut (ou null si nouveau)
     * @param newStatus Nouveau statut
     */
    static function updateStatusCache(wordIndex as Number, oldStatus as Number or Null, newStatus as Number) as Void {
        if (!cachesInitialized) {
            return; // Pas encore initialisé
        }
        
        // Retirer du cache de l'ancien statut
        if (oldStatus == null) {
            removeFromArray(noStatusIndices, wordIndex);
        } else if (oldStatus == WordProgressStorage.STATUS_UNKNOWN) {
            removeFromArray(unknownIndices, wordIndex);
        } else if (oldStatus == WordProgressStorage.STATUS_KNOWN) {
            removeFromArray(knownIndices, wordIndex);
        } else if (oldStatus == WordProgressStorage.STATUS_MASTERED) {
            removeFromArray(masteredIndices, wordIndex);
        }
        
        // Ajouter au cache du nouveau statut
        if (newStatus == WordProgressStorage.STATUS_UNKNOWN) {
            unknownIndices.add(wordIndex);
        } else if (newStatus == WordProgressStorage.STATUS_KNOWN) {
            knownIndices.add(wordIndex);
        } else if (newStatus == WordProgressStorage.STATUS_MASTERED) {
            masteredIndices.add(wordIndex);
        }
    }
    
    /**
     * Retire un élément d'un tableau (helper)
     */
    private static function removeFromArray(arr as Array<Number>, value as Number) as Void {
        var index = arr.indexOf(value);
        if (index != -1) {
            arr.remove(value);
        }
    }
    
    /**
     * Retourne les indices des mots d'un niveau HSK donné
     * @param hskLevel Niveau HSK (1, 2, ou 3)
     * @return Array des indices
     */
    static function getIndicesByHskLevel(hskLevel as Number) as Array<Number> {
        if (!cachesInitialized) {
            initializeCaches();
        }
        
        if (hskLevel == 1) {
            return hsk1Indices as Array<Number>;
        } else if (hskLevel == 2) {
            return hsk2Indices as Array<Number>;
        } else if (hskLevel == 3) {
            return hsk3Indices as Array<Number>;
        }
        
        return [] as Array<Number>;
    }
    
    /**
     * Retourne les indices des mots sans statut
     */
    static function getIndicesWithoutStatus() as Array<Number> {
        if (!cachesInitialized) {
            initializeCaches();
        }
        return noStatusIndices as Array<Number>;
    }
    
    /**
     * Retourne les indices des mots avec un statut donné
     * @param status Statut recherché
     */
    static function getIndicesByStatus(status as Number) as Array<Number> {
        if (!cachesInitialized) {
            initializeCaches();
        }
        
        if (status == WordProgressStorage.STATUS_UNKNOWN) {
            return unknownIndices as Array<Number>;
        } else if (status == WordProgressStorage.STATUS_KNOWN) {
            return knownIndices as Array<Number>;
        } else if (status == WordProgressStorage.STATUS_MASTERED) {
            return masteredIndices as Array<Number>;
        }
        
        return [] as Array<Number>;
    }

    /**
     * Retourne le nombre total de mots dans le vocabulaire
     */
    static function getVocabularySize() as Number {
        return vocabulary.size();
    }

    /**
     * Retourne un mot du vocabulaire par son index
     * @param index L'index du mot (0 à size-1)
     * @return Array [hanzi, pinyin, traduction, hskLevel]
     */
    static function getWordByIndex(index as Number) as Array {
        if (index >= 0 && index < vocabulary.size()) {
            return vocabulary[index];
        }
        return vocabulary[0]; // Fallback
    }

    /**
     * Retourne tous les mots du vocabulaire
     */
    static function getAllWords() as Array<Array> {
        return vocabulary;
    }

    /**
     * Retourne le hanzi d'un mot par index
     */
    static function getHanzi(index as Number) as String {
        return getWordByIndex(index)[0] as String;
    }

    /**
     * Retourne le pinyin d'un mot par index
     */
    static function getPinyin(index as Number) as String {
        return getWordByIndex(index)[1] as String;
    }

    /**
     * Retourne la traduction d'un mot par index
     */
    static function getTranslation(index as Number) as String {
        return getWordByIndex(index)[2] as String;
    }

    /**
     * Retourne le niveau HSK d'un mot par index
     */
    static function getHskLevel(index as Number) as Number {
        return getWordByIndex(index)[3] as Number;
    }
    
    /**
     * Définit le statut de maîtrise d'un mot
     * @param index Index du mot
     * @param status Statut (WordProgressStorage.STATUS_MASTERED/KNOWN/UNKNOWN)
     */
    static function setWordStatus(index as Number, status as Number) as Void {
        // Récupérer l'ancien statut pour mise à jour du cache
        var oldStatus = WordProgressStorage.hasStatus(index) 
            ? WordProgressStorage.getWordStatus(index) 
            : null;
        
        // Enregistrer le nouveau statut
        WordProgressStorage.setWordStatus(index, status);
        
        // Mettre à jour le cache
        updateStatusCache(index, oldStatus, status);
    }
    
    /**
     * Récupère le statut de maîtrise d'un mot
     * @param index Index du mot
     * @return Statut (WordProgressStorage.STATUS_MASTERED/KNOWN/UNKNOWN)
     */
    static function getWordStatus(index as Number) as Number {
        return WordProgressStorage.getWordStatus(index);
    }
    
    /**
     * Récupère les statistiques de progression
     * @return Dictionary avec "mastered", "known", "unknown"
     */
    static function getProgressStatistics() as Dictionary<String, Number> {
        return WordProgressStorage.getStatistics();
    }
}
