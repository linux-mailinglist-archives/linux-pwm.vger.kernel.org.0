Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616A82C6E0F
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Nov 2020 02:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbgK1BCB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Nov 2020 20:02:01 -0500
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com ([40.107.94.56]:58369
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731568AbgK1BAu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 27 Nov 2020 20:00:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaslUS9Q0i6U0flxE+BMq3uWlyVnrpFtGDCXdYO6j2HWuoabFRu4mXH7gxYXfgQlrhaVZ/5wemtbjD4ifxbJACT57bIvKgQIaYF2Ov9s0HoAAuTiChzLgoCHoH7YpM7v3iA8a2E3YCgiXtanrenco4Kr2SOWvgNMKtNriXSARm95BTHkB6dtSIWYugqbcfwkL4OIyyJdWm563qvBzNpyT1zVe/3Cx44oKAv246eKXTHzEyNbUhi/YplIvufv61WXSUcEKwlPiZjF4i7epSQM7TVWJTzmxwS/esd30L7LsmaLae7VfAcgFFUfpfwVChucwzEuXM4EozWgUi6KLS/bcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlefeEmgrkofvy6KnCj50HnkoaOM/6CH+hZCuYIgOKI=;
 b=leueWIH+Tp+Zj/IiP2JNVz23hzyFXUGV1UmLAZKmLeo8UFkCrzB1lqsSfeqfCKmDpjyT+YK/mMMb8SyDAlOdfN9Dzogu5YamwtAPkXqI3A/28W5zKj8JCtsAJpL5bxbx/wkv/7uV5lbe1GKocrTQOPyzhy1jaFe3Zj7ak6PYupJtm9kSl9fNm9zK6jvQgioXJLUWr1KvOps2CXqLBrfibuP/yG7bFyV7gz14cc6Q3AfS9bz4wqq8doOCTPfVkpfqBLLezElImrK9x3nLvFZjHrOsdK60wCIhUzC4IR68Fv6zytXpjcAgsfx9nggakoqS6cjm4MxZBDIGG5H+xRa7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlefeEmgrkofvy6KnCj50HnkoaOM/6CH+hZCuYIgOKI=;
 b=W2ksgieTT/sN+6p5rbBcxKu1S7q7PjEvvPkvkwRP6QwkDc+uJ8ETLhyC+gHLbQPqsR7OlZLxFznc01bk9Lw8Uc6HovwomBPrvl0Lgls/8ndfKY7h/M+R56CBuSrd4QrybXQ/TAUeyX0R3lVqGfaTfmhiLAM2HUpH9EWI45jGK1g=
Authentication-Results: kleine-koenig.org; dkim=none (message not signed)
 header.d=none;kleine-koenig.org; dmarc=none action=none
 header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4576.namprd08.prod.outlook.com (2603:10b6:805:97::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Sat, 28 Nov
 2020 01:00:46 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::1c46:3d4c:10eb:1219]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::1c46:3d4c:10eb:1219%4]) with mapi id 15.20.3611.025; Sat, 28 Nov 2020
 01:00:46 +0000
Date:   Fri, 27 Nov 2020 19:00:40 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] pwm: iqs620a: Fix overflow and optimize calculations
Message-ID: <20201128010040.GA9235@labundy.com>
References: <20201127201051.GA32257@labundy.com>
 <20201127203244.3439478-1-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201127203244.3439478-1-uwe@kleine-koenig.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.227.119]
X-ClientProxiedBy: SA9PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:806:26::15) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by SA9PR13CA0190.namprd13.prod.outlook.com (2603:10b6:806:26::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.7 via Frontend Transport; Sat, 28 Nov 2020 01:00:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df163c84-5944-4c9b-7334-08d893390984
X-MS-TrafficTypeDiagnostic: SN6PR08MB4576:
X-Microsoft-Antispam-PRVS: <SN6PR08MB457677514DD283306E59E720D3F70@SN6PR08MB4576.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vtqaiyHyysbai+o37h3Brb/L/f/369SEnjoiTZs4zJQTP+S9EKU8eND7ViJ2lSZiOzfPrYMG8WJeFBFw5gZ4AxR5cEvJAys0MO/gSb6srVQdmvi94TN2L9guSyySeDPrx45spsV9cSRYf386dnv8POewTu+68klnRs4N5pXZEWnZh4OsubZ6aqJleao4hONJUYL9vhZw3MIWlLKJAQkytl8CPL/21TSdJLvgzudThgeWGh1SgpOBkmNmCDwEGnoFaGIrpTwXcrLhKHx0ue2+N5UgO6ZgR5tS9VZ5uFrBQfPWcxdNnuzB6W86+nlu5Y1Tbx1LE8WUK+ua04AQZKtog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(376002)(39830400003)(8936002)(36756003)(6666004)(2906002)(8886007)(7696005)(2616005)(66556008)(66946007)(66574015)(956004)(1076003)(66476007)(55016002)(86362001)(5660300002)(8676002)(186003)(316002)(16526019)(52116002)(83380400001)(6916009)(4326008)(26005)(54906003)(33656002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?b1TH6feaLHo9snl0O/c/eMNmyw/RoZdyTxYNOyqFzXthBnjGQDCt29a3/8?=
 =?iso-8859-1?Q?s4HBaY51IWfRAK4qPoYAdRcW7L533/L4sMyQg47hhTcPj11jmC2CFjaKBR?=
 =?iso-8859-1?Q?tRfpHsLBSigq1fba/jGmzbhk1mOtjQI/MA56g6qdFGKjxPECbhfdXbBqoA?=
 =?iso-8859-1?Q?URM4Zt2JJXrxBtqQ0KPpYwU4Ckkug8fsSPAwip9wdFsrLwSU67fRG/sQLM?=
 =?iso-8859-1?Q?RkzUX2jA6p1QDlzIu9Lw9jTwJ3c3ewE16hDzRYQYc2dRtUdozQx5ve7L/5?=
 =?iso-8859-1?Q?4GLY+qlYR+cnrV1NgT9DqLCyWLjv902EEhYtuoTs4I0a1TJySDCK+CtEkb?=
 =?iso-8859-1?Q?leccSkbrBkWf/pJ9bht9gTpc3oGNze9D59G1ZkswekCFNEhvChJSTQRCvZ?=
 =?iso-8859-1?Q?9QIEt/1B8fC03XFqK+Vf4pZ0FKMVoStk/L49BCJIwpBU8+1F/XuPfi4fXO?=
 =?iso-8859-1?Q?j1jRCHsCzLTdSS/v2SFXbFd7A5ZAd7Rln2u0QyGj84hmLs7+ysqGF85igE?=
 =?iso-8859-1?Q?I1uMV3XgM8eoVeWuQ8rMg+AnqHHhTblOXKuI77MWoCqhvjCimUAr4WC822?=
 =?iso-8859-1?Q?GqG5+By2rVaBFCPnFvz9evSBG42V8OXBZJmee1u1lB5Cbcw3XDqsEHgnJP?=
 =?iso-8859-1?Q?Vdw2b4NvVv3sbVR94pcn/5E8lCSFPD8MA0EDmNa4r9q3BtW4yzCrYgkvyT?=
 =?iso-8859-1?Q?EnSOOJbl2lDDY2dxCB83wf4RTZCBBvks236joJdMDhC+KdQcXd45xFptOr?=
 =?iso-8859-1?Q?ohQyhmfvjjBSs8pEQibc7rp9Mtw/J2a+RW9Hlh+YndW2b3JmlF730F42l4?=
 =?iso-8859-1?Q?jzZOVQfROubQmlxp92JAtvzFmnmB9mP4LxYyJyTEve7Ke6/M6oKd38ANXB?=
 =?iso-8859-1?Q?0sbEtV8okT5qPqenSP+EwGyfcvyynyn3sN1hbnYBO8e0i4N7eyB6VjtsIT?=
 =?iso-8859-1?Q?nKW6hSI+lXfi+8ic1QNgX+jNLaDrDn2On28M4YZ7iWeo3eEs7UW1+GGJt1?=
 =?iso-8859-1?Q?Y4PPa12GzBLtGOW2Zbeqso91QLA8B62nmVNsJv?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df163c84-5944-4c9b-7334-08d893390984
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 01:00:45.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEnzxPWw5Jh3Jw8Zb3Ls1Wj7/aku2amIQ+YKFynxUNEKUXNDcLjIzIsAVU2n6SBp4+Up/a4RZUE2zJd6MjDwdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4576
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for your work on this; a few comments below.

On Fri, Nov 27, 2020 at 09:32:44PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> If state->duty_cycle is 0x100000000000000, the previous calculation of
> duty_scale overflows and yields a duty cycle ratio of 0% instead of
> 100%. Fix this by comparing the requested duty cycle against the maximal
> possible duty cycle first. This way it is possible to use a native
> integer division instead of a (depending on the architecture) more
> expensive 64bit division. Also duty_val cannot be bigger than 0xff which
> allows to simplify the code a bit further down.
> 
> Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello Jeff,
> 
> On Fri, Nov 27, 2020 at 02:10:51PM -0600, Jeff LaBundy wrote:
> > I tested this patch on actual hardware but the newly calculated register
> > values are incorrect. We used to get:
> >
> > [...]
> > >                     goto err_mutex;
> > >     }
> > >  
> > > -   if (duty_scale) {
> > > -           u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
> > > -
> > > +   if (duty_val) {
> > 
> > This is part of the problem; the device's formula for duty cycle has a
> > plus one that is getting dropped now (see comments in iqs620_pwm_apply).
> 
> Good catch, I indeed missed that - 1.
> 
> This patch should be better in this regard.
> 
> Thanks for particular attention and testing,
> Uwe
> 
>  drivers/pwm/pwm-iqs620a.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> index 7d33e3646436..6789e117f123 100644
> --- a/drivers/pwm/pwm-iqs620a.c
> +++ b/drivers/pwm/pwm-iqs620a.c
> @@ -46,7 +46,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>  	struct iqs620_pwm_private *iqs620_pwm;
>  	struct iqs62x_core *iqs62x;
> -	u64 duty_scale;
> +	u8 duty_val;
>  	int ret;
>  
>  	if (state->polarity != PWM_POLARITY_NORMAL)
> @@ -70,29 +70,31 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
>  	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
>  	 */
> -	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
> +
> +	if (state->duty_cycle < IQS620_PWM_PERIOD_NS)
> +		duty_val = ((unsigned int)state->duty_cycle * 256) / IQS620_PWM_PERIOD_NS;
> +	else
> +		duty_val = 256;

The build gives a warning here since duty_val is a u8. Actually, I'm not
a fan of calling this 'duty_val' since it has a different meaning than
iqs620_pwm->duty_val (the cached version restored if the watchdog bites).

>  
>  	mutex_lock(&iqs620_pwm->lock);
>  
> -	if (!state->enabled || !duty_scale) {
> +	if (!state->enabled || !duty_val) {
>  		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
>  					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
>  		if (ret)
>  			goto err_mutex;
>  	}
>  
> -	if (duty_scale) {
> -		u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
> -
> +	if (duty_val) {
>  		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
> -				   duty_val);
> +				   duty_val - 1);
>  		if (ret)
>  			goto err_mutex;
>  
>  		iqs620_pwm->duty_val = duty_val;
>  	}

This would need to change to iqs620_pwm->duty_val = duty_val - 1, otherwise
the wrong duty cycle will get restored in iqs620_pwm_notifier. However this
starts to look confusing.

>  
> -	if (state->enabled && duty_scale) {
> +	if (state->enabled && duty_val) {
>  		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
>  					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
>  		if (ret)
> -- 
> 2.29.2
> 

How about the patch below instead? It solves the overflow problem you found,
is minimally invasive and preserves the original intent. We still avoid the
64-bit division which is unnecessary anyway given this device's fixed period
of only 1 ms.

Kind regards,
Jeff LaBundy

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 7d33e36..a15a2aa 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -46,7 +46,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct iqs620_pwm_private *iqs620_pwm;
 	struct iqs62x_core *iqs62x;
-	u64 duty_scale;
+	unsigned int duty_scale;
 	int ret;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
@@ -70,7 +70,9 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
 	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
 	 */
-	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
+	duty_scale = (unsigned int)min_t(u64, state->duty_cycle,
+					 IQS620_PWM_PERIOD_NS) * 256 /
+					 IQS620_PWM_PERIOD_NS;
 
 	mutex_lock(&iqs620_pwm->lock);
 
@@ -82,7 +84,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (duty_scale) {
-		u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
+		u8 duty_val = min_t(unsigned int, duty_scale - 1, 0xff);
 
 		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
 				   duty_val);

