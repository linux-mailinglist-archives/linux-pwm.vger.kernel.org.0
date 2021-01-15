Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39E2F7163
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Jan 2021 05:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbhAOEIS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Jan 2021 23:08:18 -0500
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:27809
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbhAOEIR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 14 Jan 2021 23:08:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkVUoTrVIfArMua9VqZYVhXjqPL7vT95tNQPzadO/08qNRJHT/Yvp1ibMqNhH5ZmY/UlusWr7omXCEfFx/y0o12G+tXpn6YAY2B7t04klV2ozomudrt4jIDGTnxVHSTlTP6CfpEMkXFhHyczZCDHwNl1xYRVPkkIlNADhpOJuBZ+WktZthBXEqYg72Wj9vvtykX1OzcCx4l1lAjl39BPIpUvEoVWBGcVYLTlIjIfe5m+49SJHFRu6hWQ8bsGTO7LdH6/yG54tKizYlgoRp4DhAY1JgnQgRk+t0JUXxXHcMB27nOto0QmHusyTTAszCNQa5WJfuy08MDwy5mSkE8+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMRuWt7tQ/cYSrFvSmb4CBdxsSoOw118mFzuQieXCz0=;
 b=dylEyExd7csme64nUKbxa3VJJyGdahd7lOjVLGOUrbAA1gLSwFGsbTPCtC0HhyswtbyEM6Um5a9fP1mfhyJ8g6pAp3vzKZDSJbilQPGYEZ2PlTEU48Rt9rRBo8lcPopJX0z+Xem0jV0+Z8FGHhchvSare+uTjb/UrwFJjdBrCQYlX4RhENZfLCEL8TLuhTdBCbpV5w3Q40MAuo1AWQ5AL+QOxNdGxJXR83efUWCDbqZmel2fl/f5nlw20b4DAtRZJ065aqMFmJGIQxjIfx9c5/9UCAJ+ClRi174W9V6Zvc24wiSGLSSQncZ4LlDpee2IHoBca/DdPJ9Cpjt7ROl9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMRuWt7tQ/cYSrFvSmb4CBdxsSoOw118mFzuQieXCz0=;
 b=HrNdP/pXDuLrUD034SgXPRUsAWYqx4ivcnin6Dtl+1XHMG1s1HSC5O52NN9/wsYdqWAaVONXZPIgW8rbBDUFXrziyRuBl/0pwSWe/mFQH/wapCW5QcTRYUbzBRor8JvchQxYSztpQpr5ijcxK+WKwfVOIBmUxZUq/u4/2nFr450=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN2PR0801MB2335.namprd08.prod.outlook.com (2603:10b6:804:6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 04:07:23 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.010; Fri, 15 Jan 2021
 04:07:23 +0000
Date:   Thu, 14 Jan 2021 22:07:20 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3] pwm: iqs620a: Fix overflow and optimize calculations
Message-ID: <20210115040720.GC27243@labundy.com>
References: <20210114215026.163424-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114215026.163424-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SA0PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:806:6f::16) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.173.128) by SA0PR12CA0011.namprd12.prod.outlook.com (2603:10b6:806:6f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Fri, 15 Jan 2021 04:07:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9626554c-5a47-4bf9-ef82-08d8b90b0f84
X-MS-TrafficTypeDiagnostic: SN2PR0801MB2335:
X-Microsoft-Antispam-PRVS: <SN2PR0801MB23352A63B15B6723D6DB4D4ED3A70@SN2PR0801MB2335.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 349DbmSunTrLS0KzBO/2haIIlODAvttKFZTDWZAa8FKNELdqg8agLAspVDQOrbBOGzXJfEQ9kwe/1in+pKKdNdeApemqr+uKKx3Dnzp2j+LPjjL+30s+Z0Ue/lpyZrT6QQ0fEwx9Mw4G9+bIj5g+9fTDWh960n42ab01Em/FgWx6p3BZD8iOwSWjBYfiNAOICJuRP4ooneQNSHvg2snVOS6Cgm030aqIIN8sQa9BQr1b+3JJ1RbCZBcGoGyxAEkqIU1ucSc5UbsMwKLn0oj+hu8bGHk4BtR00ySiJmm4cZvlOyT6JWMA6/XqxbCV/s9dJmYE33NMj/fkO6zdwCRtyLyt2g+DC03p3LBCWliGbA88A3lBDqRH8+wy3zKLBa0vc2qSaVnGidopvxBK0n+Vww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39830400003)(33656002)(66476007)(52116002)(66574015)(6916009)(8936002)(5660300002)(2906002)(478600001)(2616005)(83380400001)(7696005)(16526019)(54906003)(4326008)(66556008)(55016002)(86362001)(1076003)(316002)(66946007)(26005)(8676002)(186003)(956004)(8886007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?iVdTZ+7+5xnMzVTBXfh4CaZjVZSOy0dDHARJJaqbgO/MdVi1HANe0TWu4Q?=
 =?iso-8859-1?Q?JSkqa9UsNgB7ET6eWjQOuhrR+iVxaGlyL5sB7jZOC3TiqHKyUX+TcTy6g1?=
 =?iso-8859-1?Q?JGO8Rjv7Nr8E1cBpV53jgJFBeerQrMeC1lD7nZpziR699dAxlqGQtM142V?=
 =?iso-8859-1?Q?7vgu4Cje84mIDh7s8eNzegN3ySi1hccR0VqFMKMUQ0kdeRwtSyJjGO0XHK?=
 =?iso-8859-1?Q?W9lC9SCu/5os0/QzVAEDllhItVl7xBgEf1O/73qj+imr3mXxVzqlkDEMvj?=
 =?iso-8859-1?Q?WtMbeYsGLNvtNuIMG7y8eZ9De1zgGqm6YLzpNHC9r85yMdEr4/g/TyZwZD?=
 =?iso-8859-1?Q?tBio8ZQTGZdEmhmUH0bi07RlAUuGHd4nSMgVa8d2fP30ESdi4OkhzaD2+k?=
 =?iso-8859-1?Q?3qEafMcmOZdB/ZOIS0bi2yG8wLihjHcWINcj9wCJiHyIY4n5Pi709Qlpr5?=
 =?iso-8859-1?Q?UuqkY6F4FN/6vsYUQkTkN94v+WO0nOrAcskDDQ3XJCvlSCuQjexd7FFx+C?=
 =?iso-8859-1?Q?nSIO7ylAIgiq3KU/jWkClLfdzDEdTtlBMiql281mZxylk8lZoiemBYD6pw?=
 =?iso-8859-1?Q?NCGN/4NupkV3LkoUDTFjc9P+hENisD3sjbmFOsIbDc0ToiP92ZGIRzIMXC?=
 =?iso-8859-1?Q?ZXCtlX9Da7OeSV0Lnig2ubJQaQ4PkBOiwJK/LRkG3fyykMDcimj+ZrgEkp?=
 =?iso-8859-1?Q?Kyzcc6p2IJeEJHAFLHmltPf07myIA6Z6QjjxvD3pW4eyRLeWV/scDVwukI?=
 =?iso-8859-1?Q?MNr4f8EyVxx0EhwoCyVgLqZCggIphPOoMq32DQdgOrKwO+yvoVcP7n2gnO?=
 =?iso-8859-1?Q?eRm6yp/q2l9Rcm7XnywvhC4QgC7kBW6Jpep6AtTItQR0YHx39N+qilxgXY?=
 =?iso-8859-1?Q?2sDTK5IBsld+8Of/34Zp6dplidBEDHomikXu6JyFx/0cZ1sI3L5lZeMDxK?=
 =?iso-8859-1?Q?tpYyCR3wzFBf01d9qgvpoMu+84zP+pnqsaP676SHNuNMqn5S4tsnVuAos0?=
 =?iso-8859-1?Q?WSiXMpS9vtTEXsBDP4wFqj5+kmEj55M5e+u6bX?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9626554c-5a47-4bf9-ef82-08d8b90b0f84
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 04:07:23.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kV4O+Pk605ZIctT6nS11Cvy8NiQVZT2NQf/kkJSBa9vy1UCf8n4+hJDBrqBiJFOZ8KIBPLUd/0r88F+nQOAfMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR0801MB2335
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for your work here; it's coming together quite nicely.

On Thu, Jan 14, 2021 at 10:50:26PM +0100, Uwe Kleine-König wrote:
> If state->duty_cycle is 0x100000000000000, the previous calculation of
> duty_scale overflows and yields a duty cycle ratio of 0% instead of
> 100%. Fix this by clamping the requested duty cycle to the maximal
> possible duty cycle first. This way it is possible to use a native
> integer division instead of a (depending on the architecture) more
> expensive 64bit division.
> 
> With this change in place duty_scale cannot be bigger than 256 which
> allows to simplify the calculation of duty_val.
> 
> Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-iqs620a.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> index 5ede8255926e..eb03f60c5db8 100644
> --- a/drivers/pwm/pwm-iqs620a.c
> +++ b/drivers/pwm/pwm-iqs620a.c
> @@ -46,7 +46,9 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>  	struct iqs620_pwm_private *iqs620_pwm;
>  	struct iqs62x_core *iqs62x;
> -	u64 duty_scale;
> +	unsigned duty_cycle;
> +	unsigned duty_scale;
> +
>  	int ret;
>  

Nit: there is a rogue newline here. I'm also not such a fan of mixing
shorthand 'unsigned' with existing 'unsigned int' (as in probe).

>  	if (state->polarity != PWM_POLARITY_NORMAL)
> @@ -70,7 +72,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
>  	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
>  	 */
> -	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
> +	duty_cycle = min_t(u64, state->duty_cycle, IQS620_PWM_PERIOD_NS);
> +	duty_scale = duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
>  
>  	mutex_lock(&iqs620_pwm->lock);
>  
> @@ -82,7 +85,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	}
>  
>  	if (duty_scale) {
> -		u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
> +		u8 duty_val = duty_scale - 1;
>  
>  		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
>  				   duty_val);
> -- 
> 2.29.2
> 

That being said, the patch is functionally correct and I validated all
corner cases with actual hardware. Feel free to add to future cosmetic
revisions:

Tested-by: Jeff LaBundy <jeff@labundy.com>

Kind regards,
Jeff LaBundy
