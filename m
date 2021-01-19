Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5752FAEEF
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 03:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394725AbhASC4m (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Jan 2021 21:56:42 -0500
Received: from mail-bn8nam08on2040.outbound.protection.outlook.com ([40.107.100.40]:53344
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394705AbhASC4j (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 Jan 2021 21:56:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP08o2gDvAiFIPe3n3mSsLw2VOimGl5uuuIvIOimF4Hf9FbwZmqIOnlD/FDyip3fyO8sciORlo2fPgh8UQV8BUFAKXAaHTDx5LctLFm73Idqm3nnalv7aCc3BiGKKZg51dxIYbFOMgy42MZI06mC5jD+bF3wlEr+lFnT3q3mkZU80c+KKqsBm15Ns5OrSNVEkKDf3QF+2MMezudGt5CSnmuYkNQp1cQv44wAHCDR/DME5zP7Id6oe9fn5gfBikYM6ZDpIoHasenV59IUY+UER+RnKfL+CIUUaQyZHDP0lqRLngDxsI5H0ToKERJd2vtHIRUvQId32vLteNs761+hbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/QNJ57zJS3rND3KLG7yPASafKmNEFb9WgDH+zfgSfg=;
 b=XMrZOgCgy2pzllign0enG29Nx7uH67YzxFBalbnaOBuxMSAUmBntd94ij37SVlMtx0IGmm7Eo96UxqjEwLBsIPvPgjDWfdVlvCeLFgxpiGHaCLW5fPGqj7v594A1yQIEIW8By3iS242G0SEp0Ce99lOGFYo4YrjJSXVmxdjpzTp6JZ+rHJqSi/POzKjBxNMsgY9oQNNILzRQbDgY7AZRp9L6eVXuvTjW7GDIRnf1lJjM2UrGezMsMItVwvwqbGgiuOb91mK4xc+Jms3eH6DO0fMtIVr+RPfzXY5AkmA4DFw4OH/6142vj3e3XKeIWwwQgo830bX9NoAP59mN6RBLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/QNJ57zJS3rND3KLG7yPASafKmNEFb9WgDH+zfgSfg=;
 b=Ive4ZvYo0nlej/Ng3eot3YaTTIWc/wBfTYKriNMMEzLb3OypuBjCDZoJyTGUPYwPGBvvFGwtLDhBNGqAYZy+0bExXBnn3PzOTWmNG1ug2Rl+zEUrMjTwDREU6ZzF35K/0dM7nDXlGDpN0/RWD13TmvkvXH805bOnrAKbKXw8EB8=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA2PR08MB6601.namprd08.prod.outlook.com (2603:10b6:806:115::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 19 Jan
 2021 02:55:46 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 02:55:45 +0000
Date:   Mon, 18 Jan 2021 20:55:38 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: iqs620a: Correct a stale state variable
Message-ID: <20210119025538.GA10392@labundy.com>
References: <1610686834-6149-1-git-send-email-jeff@labundy.com>
 <20210115074509.h6ytqb3dflbcud5z@pengutronix.de>
 <20210118043005.GB7479@labundy.com>
 <20210118080219.ezxukoavyi5fklgr@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210118080219.ezxukoavyi5fklgr@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN7PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:806:126::32) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.173.128) by SN7PR04CA0207.namprd04.prod.outlook.com (2603:10b6:806:126::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Tue, 19 Jan 2021 02:55:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61637cd4-8698-4db0-8755-08d8bc25b752
X-MS-TrafficTypeDiagnostic: SA2PR08MB6601:
X-Microsoft-Antispam-PRVS: <SA2PR08MB6601E2B39B03189F24EE2D04D3A30@SA2PR08MB6601.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBdx/Frbqzbfi1ncJMRHrrl2YenAKQnvW59tucx97fzmDyA3TobzwgWf2x2/zdYo+/BHhuzwRQC9YLCZs0ly6VeiUdoXy4ywVQrkjdM+hARx21QGzZSfqRQlsx+A21WUNUgjH/UmSjCI9pQzegQ3QvLwHUUJDKkuthDSbuTn4uP6fDb3WIAv+sHNPWP6M+mAsYDCPGjwfaKXlXr5+gfT3vjjqFN0q5zSQpswF+MMZ+Z4IiXQeTCidNiL3slf8nF/MbOpBYqzN7r5c7pq64O3WSNPuSTd4mJA08b3raIyAvN4xfNph86gAUhGxoEQBwrrI54PeOsjwOTXwvxyIoVFbvoDpPalkN4rkmIKXtvodzciC8VCzWNf1yMFL1wcTSOZe4tq8hiJR3XRUS1fTXAPsSC+FTjAzLwdgrbOHaksp/Ov5Ln2KtzUqvtFQG762k7zXzluX39TbZbXm8RLMMNDUNMLeos9jDVPWbVLs2eX6hVtJ74wlc5b5r2dqwXtFDO/tLqIhKg6guaWVkHJCr1Plw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(376002)(346002)(39830400003)(66946007)(316002)(2906002)(86362001)(956004)(1076003)(66574015)(55016002)(66476007)(66556008)(83080400002)(478600001)(8676002)(16526019)(8936002)(4326008)(26005)(186003)(966005)(83380400001)(33656002)(5660300002)(6916009)(52116002)(7696005)(36756003)(2616005)(8886007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?Ogmk3vwp2yiW0EF+LAjOkJyAYpzEsEYeTncRxtvrR9/yWOMy8yo7YlkvQd?=
 =?iso-8859-1?Q?n59R/CjFb54dwHC+TCmJd9Iy+gY3PHwtd62oAm2hjDWRTlGYb4JFLko1Dk?=
 =?iso-8859-1?Q?mz/yzyt+3bg/iT+8G8hKfa3Sho+Nl9LPgNEXi/GFbW5v3+sfXKhf9mhBT6?=
 =?iso-8859-1?Q?R5rjAfzpmWcEzky3nRRWZ5LdDrCJH3aGA3JJivJ7nbFJ8Z60vJBT52n255?=
 =?iso-8859-1?Q?/9/IiFKQwqhI3EJc5hXD3YcS3GBlNilkPiHG5WBh2eCtTJt+JwRZ4FVn5Z?=
 =?iso-8859-1?Q?uniKKad0S6JbGEt0SwKMOPsYSID8X8D2ksWLHhygmdyBOPHiivsALcLGbR?=
 =?iso-8859-1?Q?bDHVFEF6r4Xnsw3n6X54RA4vX4Tgm9pqMsSS5gh8jWXfqTM3WeHinxHrEX?=
 =?iso-8859-1?Q?3AMv6/zNR3PN8J0HnzFdd8UBrctInwA6zPpYA9vusMaMFD72FcTp9IxDnc?=
 =?iso-8859-1?Q?ifC0ube2bWGmLEuBz2z1RIIf4SIrRtzoZjCsYlzoOuvxKmvsy9/gLd29fW?=
 =?iso-8859-1?Q?fJwbvX+g5+qTOaqjpZJU1VOhVLqHyOsYO2P+hE+mI6kpftLW21/VGf74O4?=
 =?iso-8859-1?Q?iHBG1rYYTK4on8w91Sl79BYSAgoQ+zIGm7b6vbLTcxSaMzKcg+SlxW3D9y?=
 =?iso-8859-1?Q?XDDwNW3XnuULUqKjbaYRXIHgaQGi/RVAL7LUV/8/iBLhk1afuk26SeA7oR?=
 =?iso-8859-1?Q?pLA3+bAglSD+q4cQrE8wbmCmQt0Etd1nwsQRwxPvF6ddxxjymkiSd5DC+j?=
 =?iso-8859-1?Q?BXRcNM7HvdKDYhG7mtQ68uSxfC8+pxg6d8M1wBIkitdNOQfno+rKbjB73m?=
 =?iso-8859-1?Q?67otTWc6r2TFj47WN9fieqxD14X+c3AMVYHdAIFnA5Jab/6Vl+Sc82oTQ6?=
 =?iso-8859-1?Q?4FYrI5XZZaAVXVJJC8xSm9qf/qZp81fJCMKwBdqL4Gnq1Vy+VDXdPB5qdJ?=
 =?iso-8859-1?Q?OVbwgkmC24lC+smoKjxs33Eu24AFGN44t92boonLBnVDi5Mhc9uVdORVuv?=
 =?iso-8859-1?Q?98OgE8lssOYqmf9qFpe2jfZCfiYw7XgS02p4sa?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61637cd4-8698-4db0-8755-08d8bc25b752
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 02:55:45.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSBYEvBDtgYGFpFlA6Wm9McaSRFioWNj3Z9dOmc4zEALvFbfhK08DcN/0Dy1qo79ExKsrQlh98h9U5od6kHYNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6601
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Jan 18, 2021 at 09:02:19AM +0100, Uwe Kleine-König wrote:
> Hello Jeff,
> 
> On Sun, Jan 17, 2021 at 10:30:05PM -0600, Jeff LaBundy wrote:
> > Thank you for taking a look; actually I came across this problem while
> > testing your patch, so I owe you even more gratitude :)
> 
> :-)
> 
> > On Fri, Jan 15, 2021 at 08:45:09AM +0100, Uwe Kleine-König wrote:
> > > On Thu, Jan 14, 2021 at 11:00:34PM -0600, Jeff LaBundy wrote:
> > > > If duty cycle is first set to a value that is sufficiently high to
> > > > enable the output (e.g. 10000 ns) but then lowered to a value that
> > > > is quantized to zero (e.g. 1000 ns), the output is disabled as the
> > > > device cannot drive a constant zero (as expected).
> > > > 
> > > > However if the device is later re-initialized due to watchdog bite,
> > > > the output is re-enabled at the next-to-last duty cycle (10000 ns).
> > > > This is because the iqs620_pwm->out_en flag unconditionally tracks
> > > > state->enabled instead of what was actually written to the device.
> > > > 
> > > > To solve this problem, force the iqs620_pwm->out_en flag to follow
> > > > the IQS620_PWR_SETTINGS_PWM_OUT field instead, as was the original
> > > > design intent.
> > > > 
> > > > Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")
> > > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > > ---
> > > >  drivers/pwm/pwm-iqs620a.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > > > index 5ede825..5eb8fa4 100644
> > > > --- a/drivers/pwm/pwm-iqs620a.c
> > > > +++ b/drivers/pwm/pwm-iqs620a.c
> > > > @@ -79,6 +79,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > >  					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
> > > >  		if (ret)
> > > >  			goto err_mutex;
> > > > +
> > > > +		iqs620_pwm->out_en = false;
> > > >  	}
> > > >  
> > > >  	if (duty_scale) {
> > > > @@ -97,9 +99,9 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > >  					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
> > > >  		if (ret)
> > > >  			goto err_mutex;
> > > > -	}
> > > >  
> > > > -	iqs620_pwm->out_en = state->enabled;
> > > > +		iqs620_pwm->out_en = true;
> > > > +	}
> > > 
> > > I got the problem and I agree it needs fixing. Are you aware you change
> > > the semantic of out_en here and so the behaviour of .get_state()? IMHO
> > > the change is fine however, and unless I miss something this patch makes
> > > the comment in iqs620_pwm_get_state true.
> > 
> > Agreed on all counts; in fact I saw this as an improvement because the
> > get_state callback now reflects the actual state of the hardware under
> > all circumstances.
> > 
> > As you mention, the comment in iqs620_pwm_get_state() is fully correct
> > now too. Previously it was incorrect in this particular corner case.
> 
> ok, I wondered if I missed something.
> 
> > > Other than that I wonder if it would make more sense to track duty_scale
> > > in the driver struct instead of duty_val and out_en.
> > 
> > You would still have to cache state->enabled because it's required for
> > decoding duty_scale at the time it was cached, so there is not much to
> > gain. I prefer this solution because the get_state callback is correct
> > across all cases now, and the change is small.
> 
> Can't we cope for this by just doing
> 
> 	if (!state->enabled)
> 		duty_scale = 0;
> 
> ?

This is an excellent idea, and simplifies the driver significantly. I'll
send a v2 shortly.

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Kind regards,
Jeff LaBundy
