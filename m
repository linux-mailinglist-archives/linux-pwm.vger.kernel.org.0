Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38642C6C82
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Nov 2020 21:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgK0USz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Nov 2020 15:18:55 -0500
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:25185
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731331AbgK0ULc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 27 Nov 2020 15:11:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDpdb9IFNcTnHDQQ816Phn3MQeSb+u/6hc/qnHHvnVowShrp76fR4ggIzeuKErqBZxM0VlH8A7JJIS4GzpCjHXA9HCuCZ90c72zKfvBXCLx5GhVIVwEbjeb8FK7e1VMnTFzYLrDhVFBOmmtA8fDDPDNowGq5mZlv0rOYF/ydcxu+Edb8kimPAb+vJmx57rS2qi2okDR0PdJkQTwrSeJJLLiS/UCi/0KW2Ln2zGYa4IuFCecivk422/8lTjdk1cQ+011NG7rhfRnJy1snekgfw/J2oQRz9v49UkLafBsGYWxJDzztZmMuzMhVPk0Rq/Z/lGajlA8lpxWgn8Wg2lN6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnS0qKXwQXpPi5U7RoHH8Cu9hRUbc5CemAfcKh3l3io=;
 b=k4c2n+rHsEvmfRIWy7Nqg7E7pRV7s/NTgoAS/m9kaYW2T3e6/xfPV4urQlu+N51qqxo66ZlH0dCZvNyuqV60dSDHdlk6leQgtQ64zWwXYd9rhwak0ij6FolNEhXfuFHyUVa2fIbzqFUQQKYzHSKiP4ZIBQ4r1QwxaTSXozliXNl9rxFkzOVmtuMbH73dMFvBkpsz+8Tlpx5vkSK3sobZTQNdRn6ipNptk1uucc2mhlprvK7XlvYHfft6d0ypaqtWNyo5QlcCpQAMIExy5QTMYKslOIexbS37w2VBUE6xtr8rZnBPP8JYKi3Qwi6PqLnbBLo6S5gSdiyQdkfkHPTlrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnS0qKXwQXpPi5U7RoHH8Cu9hRUbc5CemAfcKh3l3io=;
 b=rvXxrxftlA9O7Wt44fBtYX9z/Mm5bYVnWhu9/1Hy0J+3Re9afZIFHa6o2kA4BPxSMntf6pTGc0rKNp1iYaUWwM3ns2VgoD0MbDy7pE7BWhbpIgsfnQrTu/OMQjXOHqj+XvR7R93zMfedUaylhpeJy7IkJM8A1LrP/IRUO4jhObc=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA2PR08MB6555.namprd08.prod.outlook.com (2603:10b6:806:111::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Fri, 27 Nov
 2020 20:10:59 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::1c46:3d4c:10eb:1219]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::1c46:3d4c:10eb:1219%4]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 20:10:59 +0000
Date:   Fri, 27 Nov 2020 14:10:51 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: iqs620a: Fix overflow and optimize calculations
Message-ID: <20201127201051.GA32257@labundy.com>
References: <20201127141403.3433678-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201127141403.3433678-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.227.119]
X-ClientProxiedBy: DM6PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:5:334::30) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 20:10:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9bf1d0e-c640-4fea-916e-08d893108e6c
X-MS-TrafficTypeDiagnostic: SA2PR08MB6555:
X-Microsoft-Antispam-PRVS: <SA2PR08MB6555C2F025E981273055406CD3F80@SA2PR08MB6555.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2TSxSxAHiSnDB0Z8Fgq4qN+wDHfxs+X5OFWN1JYHksJJiJraTJ9InN5fNP4g+TO2rkSMuz1oxtu+GoNd9viu1zitjG1iAaVqFBn6YObZM3gsiQTWDaBhotdFhjBR5MDbMBdFjwagIYeaTT2/DrL7bOnaZovXaRDp6vPX9zbcoP7WDYreOSaxqOyubUxW3AEZoADQRtR9JD/GoT3JQ3R/2FqMUAAp/TeQ8rtvqnn8nfzslyndvGPGa5HVabAt4BGbIlz/pffbs5acP1yvcK2raI+qjGluaj56FMVv1ar1dgU2tKcW82mlOSk1KkQwzqa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39830400003)(136003)(366004)(316002)(55016002)(6916009)(86362001)(5660300002)(52116002)(33656002)(66946007)(7696005)(26005)(186003)(66476007)(66556008)(4326008)(8676002)(54906003)(8886007)(16526019)(2906002)(36756003)(83380400001)(66574015)(8936002)(1076003)(478600001)(956004)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?12cmUtHxdb4h8rmrxdZEWLI6s/1if7lCbS9x7wQEnfAExm1Az3N6WxtVaS?=
 =?iso-8859-1?Q?hh27xh/96cgKcmmkf0YauBBmnXH4DvZhJTFsM2KvRWkSsF+xkdylXpevUo?=
 =?iso-8859-1?Q?Z9C922ljSlAbDjQilyZi+XNGJFg18LAmcPShgEO2IJ6bOQceQ+YL0xGfVM?=
 =?iso-8859-1?Q?Rj1G8sVaOef9kKrqXDa/OoteJOhkFcUDnnzVFe9tsQSuubia/BqfCCXT0o?=
 =?iso-8859-1?Q?axyGJiTXfoj7xxL+WuMXf6cqUeHbh+UBLRMeFdRrmRnSPNvrQ7ljptpwh9?=
 =?iso-8859-1?Q?uRfT+4rjR0iWfgd6gw2bAWHC8dJGPJ6Ct8C0JsulXRCV8tCqJ8lWEW76Uc?=
 =?iso-8859-1?Q?ytvOvL8yztU0tcDUUpSV8yPFLLzEMhNpVAxhwnWuTtV1YoaVXFImySGeOS?=
 =?iso-8859-1?Q?lQ+9yTavI2PzZ9j9vzn81ZadeIXM4Kep0BjcjeJ8BySENMEDK7R956aS+J?=
 =?iso-8859-1?Q?Uo9s0B4snpNhivL97Nw68P5CQszYIxLH6lriH0cy2gcLUAFyl1MFw4c0mD?=
 =?iso-8859-1?Q?cD4eA+HFdGd2ddQtM2SrVvmMvFUoN7QYfV4zOjyOMs9KpTn3YZSO1gVrgj?=
 =?iso-8859-1?Q?fgD8vudtWAzmZUbwCSoHFRJ1BYC4EUEPeh7MevqvCIkL6Hl62rVAFsv4ri?=
 =?iso-8859-1?Q?bGdCp1yiEnVmUq/84WwZxQUpbhocEA1SyZ+SQoBDm8y3Ed4snhcj2qu2Pp?=
 =?iso-8859-1?Q?E/294fBvNIZsVMey0eHlrUKyg22Hpq9u0TxraRUcMt7OZJ8NStGIPd2Oj2?=
 =?iso-8859-1?Q?KdZwQ9Mo4cp7bmQKLWFapJA0tzBwxWGugHHE44ZhZF8ERkedtySqcFGaQ5?=
 =?iso-8859-1?Q?tDWV0sajZIV/VdwTAoQg4+kq3r3PzLlaTfHM8lRZSVEVtI2oD6nSdVEui3?=
 =?iso-8859-1?Q?IIDfoqaRJcT3NRK+SXfaFaTpFzHBrApzu1hEeo6JQXQVV3yrOvjAsKVBw/?=
 =?iso-8859-1?Q?AHqM2SY5ozRkoWN2zsDTIZcCSZQ9zydZ2LQmdQwZN7BT1SCgrtNIY1x2Ou?=
 =?iso-8859-1?Q?thsu6h4apWSXREhLmQHBAF+VzyjGff2QGF7Pvi?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bf1d0e-c640-4fea-916e-08d893108e6c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 20:10:59.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3sFJW+Bedm2QRVFzDK1mM/tM0ZO5T1FuvyMy6V1oqTh/cDnbRTQTOMJWSdzO/vxLesKjIZS7fis3aQqIpLMmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6555
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

I tested this patch on actual hardware but the newly calculated register
values are incorrect. We used to get:

duty_cycle    reg. 0xd2 bit 7    reg. 0xd8    pulse width
----------    ---------------    ---------    ----------------
1000                 0              N/A       constant off
4000                 1              0x00      3900 us
8000                 1              0x01      7800 us
1000000              1              0xff      constant on

Now we get:

duty_cycle    reg. 0xd2 bit 7    reg. 0xd8    pulse width
----------    ---------------    ---------    ----------------
1000                 0              N/A       constant off
4000                 1              0x01      7800 us      (x)
8000                 1              0x02      11800 us     (x)
1000000              1              0xff      constant on

A comment below.

On Fri, Nov 27, 2020 at 03:14:04PM +0100, Uwe Kleine-König wrote:
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
> Hello,
> 
> even though this is a fix, I don't consider it critical enough to apply
> it before v5.10.
> 
> Best regards
> Uwe
> 
>  drivers/pwm/pwm-iqs620a.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> index 7d33e3646436..0c9e2a876a05 100644
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
> @@ -70,20 +70,22 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
>  	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
>  	 */
> -	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
> +
> +	if (state->duty_cycle < IQS620_PWM_PERIOD_NS)
> +		duty_val = ((unsigned int)state->duty_cycle * 256) / IQS620_PWM_PERIOD_NS;
> +	else
> +		duty_val = 0xff;
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

This is part of the problem; the device's formula for duty cycle has a
plus one that is getting dropped now (see comments in iqs620_pwm_apply).

But since you're clamping duty_val to 0xff ahead of the zero check now,
simply writing duty_val - 1 instead of duty_val would prevent you from
getting constant-on.

>  		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
>  				   duty_val);
>  		if (ret)
> @@ -92,7 +94,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		iqs620_pwm->duty_val = duty_val;
>  	}
>  
> -	if (state->enabled && duty_scale) {
> +	if (state->enabled && duty_val) {
>  		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
>  					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
>  		if (ret)
> -- 
> 2.29.2
> 

Kind regards,
Jeff LaBundy
