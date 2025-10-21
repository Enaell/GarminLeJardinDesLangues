import Toybox.Lang;

/**
 * VocabularyData
 * Module contenant le vocabulaire HSK 1 et HSK 2 (environ 300 mots)
 * Chaque entrée contient : hanzi, pinyin, traduction française, niveau HSK
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
        ["左边", "zuǒbiān", "gauche", 2]
    ];

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
        WordProgressStorage.setWordStatus(index, status);
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
