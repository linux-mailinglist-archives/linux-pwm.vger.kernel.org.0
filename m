Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84E2F98AD
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Jan 2021 05:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbhAREbG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 Jan 2021 23:31:06 -0500
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:5473
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbhAREbC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 17 Jan 2021 23:31:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIJ+Aw4m0th+mh1hqluw32Efh06m3PQtLe+EDH4oaM346kYgWkz1OgpU1TGfH+Gs0aa0NGgF6G/vwjChEBbXx5aJlDsSFvom2ORA0BKbIv9sPmYiTA2GV8i1e88G6sZvZSNmO2m6N3cvcwh53NPFezNwPKDqGs6n4ECCxlLlLTMHxbUXeE1VRFvGry+BcQ74QHuL689KYQvMvW0t0pUP3I2hJIiIvqQIgM/bBbfOZPJrkCqWfi1JzvnSPAjMcWjjmnXBtnMStpqEHDU5Zcz3rySCYfdNWsvKy/kW/AJJ/LeqLcFD9n96lyVLViQ30MfAjqtBqoRoJvGkPlO/0JMDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Kf/w22APgLg8Wo0V81tV+E8PTkjZ32ZaH/zgla1zxk=;
 b=lXX6+t8hMMwDMq/p+H2Qg8zMNNUaqvdPh8TmkJRlyKGtYpZpfOK7T/7ZAeLmr2aPZ370k0UNaDuXItrVP3j8rUmsroTRLN92roelujRWfSoMgAQpHY963LTwo1xRO2D8z/9YSmduHsbuRvigVdgW8Sm4wHlyGrrrlJJKR6m8dY9rMFZbLFmro1X6C6YNQawMs8qxYbAO39+D7UafaG+ahdGXXMwAib1zYduOckeg+eNqkIrIq83hzafVmo7dJdo4GQtgscuZdK0USqXuxW+R3m25ftisNVYRbR7wwzBc0gO7S3VwY4YmjTnCZ3IARLVwhD+isBYnhjaXrSRyF6szIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Kf/w22APgLg8Wo0V81tV+E8PTkjZ32ZaH/zgla1zxk=;
 b=mOMUNuj77Wa7fKp3/B2uNjQLg9XlH65itAeY+C6WOKBrLpKhCFkKtubH6TEzRBHudfWTs/7qiLJcrG9Ax4V4eJ46/d5qNNamiqWXoBXOTINrs6H5SyAWwP/L1H1iyzbq7ZC64K0IWbtdqIbmQUzzY+uoWmL8HSQYHvVtCwDORrE=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB6112.namprd08.prod.outlook.com (2603:10b6:805:f4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 04:30:08 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 04:30:08 +0000
Date:   Sun, 17 Jan 2021 22:30:05 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: iqs620a: Correct a stale state variable
Message-ID: <20210118043005.GB7479@labundy.com>
References: <1610686834-6149-1-git-send-email-jeff@labundy.com>
 <20210115074509.h6ytqb3dflbcud5z@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210115074509.h6ytqb3dflbcud5z@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN1PR12CA0096.namprd12.prod.outlook.com
 (2603:10b6:802:21::31) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.173.128) by SN1PR12CA0096.namprd12.prod.outlook.com (2603:10b6:802:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 04:30:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846228bc-fa99-48c9-a35e-08d8bb69bc48
X-MS-TrafficTypeDiagnostic: SN6PR08MB6112:
X-Microsoft-Antispam-PRVS: <SN6PR08MB61121EC966D5E19B6230E1B0D3A40@SN6PR08MB6112.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DCM+YuatBfI0+Kq569JehDmNhWqgw78inag06NJPwaoTNDGx0oZIQV1eGWR7AzPqDfGfrYUoI7bl9kLyzVfq9Slu2KcM0cQmBPd/c21wa8jCl60dThEkYd32RLTdM2EB45wEMC3LJHfDRjr+fUe2OPK1kM/GPYfXTVESsFMR2oVEU/B0pIMSvrqaFC9q7jlKXSYr5Ky6QyiKSZF6ZQpBiXR3/g8hhve8SabXLeRF9m71UOdMgKBSeNNpn3d+iAqjmeAzw/npVVpFTALU3u8NRlrdCX1Xna5gFxVJ188Ozz30BKbQgFxsHSaRTQbXRUfrn9UVDrAb3V09KvutcWQnUlc8I481fCfgF13oYIK0IVHCfqu876DhNOYYaMws4JznNy8r7fjphL6rHv9wbNHyY072IxKuZ4srHpO8JXNq3Ey1kogzi6WPoVAqy3G1Cyp3jsTLEl11IhZ/e7fjRHZnK65eRPuqBGG1A+3HYdb2MBcmQ/nGT08fmjVWZxlmbtAD7i8Ik0pKgFEiu5YmU0OJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39830400003)(396003)(366004)(136003)(186003)(36756003)(4326008)(33656002)(16526019)(26005)(8936002)(2906002)(66574015)(52116002)(478600001)(86362001)(7696005)(956004)(2616005)(8886007)(8676002)(83380400001)(66946007)(1076003)(966005)(83080400002)(5660300002)(55016002)(66476007)(66556008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?XPlWfd+17a5aDKVAmdga3GM05ke5FJz71OhPcbWhllxgxA0p8CFe/JHIZs?=
 =?iso-8859-1?Q?rioMCxUJ6oeD6jUd3yjpDP9NgcpwjhqwdDwExu6BGL7SawrQG4iHVJr9cW?=
 =?iso-8859-1?Q?+70pPl7cPk859I6wjlHKMb012ORz3REAGWK4mLu/4gQTAvogZ642W51wA/?=
 =?iso-8859-1?Q?sv1NjBYpP6Xd+neKwruyMbZiHwj3/w1OjzjJhg//O+Gs31Iun9W6Lcbgh3?=
 =?iso-8859-1?Q?7siRyQIqgDKsLK7jTYGwpIo8Pac39uc5T3ct3LlanErmjYQ5FSpqet7LGu?=
 =?iso-8859-1?Q?xvkr4PYdBMb8AFFg+rUPHb+2EGmZj16lLcvCSMKq56AvybZ8T4M+FTPb4V?=
 =?iso-8859-1?Q?BVUK/+j+5PCiIRXW9OF8axcn8+ECC6+aZbL7EBWiEV3CXW/kUBm90Pgz5o?=
 =?iso-8859-1?Q?UlJaLgBZ6UuW0WwE7GfR2qRvNqqxyRKKtsWQNc9m5PeQEDVR3Ht6XYnNke?=
 =?iso-8859-1?Q?YTbqeaEoheOyXnhvJklYtvzJv344MYoe1BK/ps4MnGa9RztWoo4Q+QZanQ?=
 =?iso-8859-1?Q?L3NtF7VQQ9xDQR9QvOYFxqlnZqPSHy3uWWFnwba0V8y3snqixlnvX5bNes?=
 =?iso-8859-1?Q?7ikYJ3fwzbytw62Yl3JGKR3s+JhWMwp7TMJ+BMh08mjDKLfuWmslPXGjw7?=
 =?iso-8859-1?Q?V2dvcP1STpJokw13B4k4aTbIQd5b3y/VtUsK6h6DR8sHYMZxiMy8Hyf+wm?=
 =?iso-8859-1?Q?DZEkrKYyVIXYTvGYHPCNR8Xb86s/aHHB6H79l8lC/Ge/NC4OWXqj1r31i2?=
 =?iso-8859-1?Q?j4IAZ/xjt+IK1PYr9l5skBSP4CeQRsQYBGwuU4m9WHVuoeMnJU3pIuQAh4?=
 =?iso-8859-1?Q?p2YMd3Rgjx5jTwwytSZDAg9gJxdUK2nUtggUIuW4QGdLfHc2u1VIOTQAcL?=
 =?iso-8859-1?Q?PeIbSFiFYk+NW/+BNbHKaL9XJFI0txoVjwHRrByrnB9xOfomlaNa5tjVVG?=
 =?iso-8859-1?Q?x5TkxSpgZFDbmV45rGlMKTQdE7tDsiJXvGJsNet8AD2mQ+dCv3Y6Ev1GzX?=
 =?iso-8859-1?Q?rdFzR8Dy//Fd8F1fClgNarb98kjXaV7FSGVA0h?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846228bc-fa99-48c9-a35e-08d8bb69bc48
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 04:30:07.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLT31HusMvHS67SVFOyST2SBg19p1Oxr0NfjhNxf8I1f3GNTxj3zUhYqRkP71stH0BAB8H5GGNONGQeUbpvYoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB6112
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for taking a look; actually I came across this problem while
testing your patch, so I owe you even more gratitude :)

On Fri, Jan 15, 2021 at 08:45:09AM +0100, Uwe Kleine-König wrote:
> On Thu, Jan 14, 2021 at 11:00:34PM -0600, Jeff LaBundy wrote:
> > If duty cycle is first set to a value that is sufficiently high to
> > enable the output (e.g. 10000 ns) but then lowered to a value that
> > is quantized to zero (e.g. 1000 ns), the output is disabled as the
> > device cannot drive a constant zero (as expected).
> > 
> > However if the device is later re-initialized due to watchdog bite,
> > the output is re-enabled at the next-to-last duty cycle (10000 ns).
> > This is because the iqs620_pwm->out_en flag unconditionally tracks
> > state->enabled instead of what was actually written to the device.
> > 
> > To solve this problem, force the iqs620_pwm->out_en flag to follow
> > the IQS620_PWR_SETTINGS_PWM_OUT field instead, as was the original
> > design intent.
> > 
> > Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
> >  drivers/pwm/pwm-iqs620a.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > index 5ede825..5eb8fa4 100644
> > --- a/drivers/pwm/pwm-iqs620a.c
> > +++ b/drivers/pwm/pwm-iqs620a.c
> > @@ -79,6 +79,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
> >  		if (ret)
> >  			goto err_mutex;
> > +
> > +		iqs620_pwm->out_en = false;
> >  	}
> >  
> >  	if (duty_scale) {
> > @@ -97,9 +99,9 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
> >  		if (ret)
> >  			goto err_mutex;
> > -	}
> >  
> > -	iqs620_pwm->out_en = state->enabled;
> > +		iqs620_pwm->out_en = true;
> > +	}
> 
> I got the problem and I agree it needs fixing. Are you aware you change
> the semantic of out_en here and so the behaviour of .get_state()? IMHO
> the change is fine however, and unless I miss something this patch makes
> the comment in iqs620_pwm_get_state true.

Agreed on all counts; in fact I saw this as an improvement because the
get_state callback now reflects the actual state of the hardware under
all circumstances.

As you mention, the comment in iqs620_pwm_get_state() is fully correct
now too. Previously it was incorrect in this particular corner case.

> 
> Other than that I wonder if it would make more sense to track duty_scale
> in the driver struct instead of duty_val and out_en.

You would still have to cache state->enabled because it's required for
decoding duty_scale at the time it was cached, so there is not much to
gain. I prefer this solution because the get_state callback is correct
across all cases now, and the change is small.

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Kind regards,
Jeff LaBundy
