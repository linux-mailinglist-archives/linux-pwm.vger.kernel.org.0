Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7281420ED
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 00:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgASXcp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jan 2020 18:32:45 -0500
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:23073
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728886AbgASXcp (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 19 Jan 2020 18:32:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGTo7ASS/ToSIbemS0hLEmtb+7H6tOO96Wk1y2v4C/mfAnqTEoSNF7NxWLAc0BM/+zbBBsoMKxI87qEvA3mC4M1enr6egppBacyEr4s2Olk9jO0aHZY9MgaPgczD8HXf2vKSDLdk8QpgPSH6I7bPV41cBCQxu4hMsXNT4zIJM9Gx851LMYRua619nv0QwcELM8WtSfrBNZwahicSk3sd81gOvAoDwebhLz+AM0mQdqDwUcXFvaS7B7dgb+j/+q8J/TdnO5arM6xdKRJvZ8wD5R2hGSvU98p/2ER9zcvgMNWKqV9yB49Z4hOBgTFpT1aUNybWHcIB817MW67vMaaMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qOez9c5WaQWJrK2OJfrt8xyVD+AxcecVy5cM2JAIFg=;
 b=AE1hXCqhYcsIq4ExbC4uQejFQTJDWQFTVGaxMTgbNF2lPLGJCsppu3frVq+yQQopbz/cHDCSGEYmVP27cwTEe97V7FgpXQMrO3bU0hfj8o2fyKpysdeoFOaeWHbl8PtPQORAtJT4ZfETZ/Q/JTGSsx7oLUXRtbhkZ1YlJwP+hp8G0EOjmsjRxrl3e0TMw6cBuUkeLsqwVQRG8cp6h5oLpGRNcGSPjssh+gzoZ0ImHUznls+7VpogecFxRN0kaup+uCbhGpnfs6xMa3t7w6to6iJ2lpNQAISwoPlI7xsLrgs3DQS6kNMeHra/qaZTmyOoatZJ0RZbQjRHy4LBNO+ztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qOez9c5WaQWJrK2OJfrt8xyVD+AxcecVy5cM2JAIFg=;
 b=qIJeo8Ua6AmoLPzxCoc8qvR6KDB58DFdoefnFRpbge/zSww9fbbr2LE3EHCsOls+i2L5/09mSrJD5AzkQffS7+7zvCXqS5EY1jSvu4vpalvRg4WP+FVZQyOVPLOmRyGmUKjwy/dLRbvCnWNfJI2KJvzcPvPrJ9RWhP3PbM+4M/Q=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5454.namprd08.prod.outlook.com (52.135.116.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Sun, 19 Jan 2020 23:32:39 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.024; Sun, 19 Jan 2020
 23:32:39 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Sun, 19 Jan 2020 23:32:37 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVzN7ZeNwr91HvDUacFRX9W6PqAqfud1qAgAQwWwA=
Date:   Sun, 19 Jan 2020 23:32:39 +0000
Message-ID: <20200119233234.GB28865@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-5-git-send-email-jeff@labundy.com>
 <20200117073427.ufrduwagvppeasgr@pengutronix.de>
In-Reply-To: <20200117073427.ufrduwagvppeasgr@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34bdedc9-1d58-4875-dfb4-08d79d37df3f
x-ms-traffictypediagnostic: SN6PR08MB5454:
x-microsoft-antispam-prvs: <SN6PR08MB5454D3002114C16CB12884F1D3330@SN6PR08MB5454.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39830400003)(396003)(346002)(376002)(189003)(199004)(966005)(86362001)(26005)(54906003)(2906002)(8676002)(508600001)(7416002)(7696005)(8936002)(52116002)(316002)(55016002)(81156014)(81166006)(33656002)(5660300002)(6916009)(36756003)(956004)(66946007)(66574012)(186003)(66556008)(64756008)(1076003)(66446008)(8886007)(2616005)(4326008)(71200400001)(16526019)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5454;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YVrVDk7eoO5uSK23aERFZYk6UWTtDgMeGAVHMqWhhEHP3rJIunIOqj6wH/wiFLdrbNK74d7dgQv+B1pJ9in7E/o8VNgL7UAjBZo9RjH5xvwG58yBE+93bMgarOYmlAxxj9rZUVtS6/YiMfEv/OBS4TzGHZomTxhU3DWE3oJRPFEWHM4noxb8neft7HTdqLCmHEubP4nLKC1HpZDXSahECHV6UQaOKDQ5kkZly18HkXfBgkmuAjtfdAnspBd4Zx9i1qBX+7f7t+DOZX1tH1zNkxIsnmlx0ALNAxJy2vhVEmu8K1j937aqqYW1jTqr05p3i2g9i4qcnDGi2b3dROM5PRj4xCE51p8L8+2uk3tTqslnHnd17yLuunzTW10lGPu/DUFTpHwcsQTTkPVSfJWIDiJfi+QIqxqpgYCpOHLQ0919AH2pzRuwK0dZjCIPnwGN4fossexyPSvpAMq0Dt9AZMkEvsotaxim8uCguDMbuGJQbdoo5SO2TRyEWeVdzLcTBtZHx4RYv5r2NSDIaIn4w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <27FE836ED0F0A9438BA43F2D866F9921@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bdedc9-1d58-4875-dfb4-08d79d37df3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 23:32:39.3909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ii7m8T829l/QxfbolzaoSgIVrypu94Kkr10AuSkgqxnr/Pr12tWj5f5HwFeOei47it4NPey6xTvlhC5LYU54ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5454
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for prompt review.

On Fri, Jan 17, 2020 at 08:34:27AM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Jan 17, 2020 at 02:35:57AM +0000, Jeff LaBundy wrote:
> > +static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > +				 struct pwm_state *state)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +
> > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
> > +
> > +	mutex_lock(&iqs620_pwm->lock);
> > +
> > +	/*
> > +	 * Since the device cannot generate a 0% duty cycle, requests to do s=
o
> > +	 * cause subsequent calls to iqs620_pwm_get_state to report the outpu=
t
> > +	 * as disabled with duty cycle equal to that which was in use prior t=
o
> > +	 * the request. This is not ideal, but is the best compromise based o=
n
> > +	 * the capabilities of the device.
> > +	 */
> > +	state->enabled =3D iqs620_pwm->out_en;
>=20
> Hmm, when .get_state is called first (before the first invokation of
> .apply) .out_en doesn't represent the hardware's state but is false
> unconditionally. This makes it hard to take over a running PWM setup by
> the bootloader.

This was intentional, albeit poorly documented on my part. When the parent
MFD driver probes the device, it issues a soft reset (which returns all of
its registers to their default state). It then loads firmware (essentially
tuning/calibration register settings) and then triggers the device's self-
calibration sequence.

Both IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE default to zero,
and the firmware does not modify these. Therefore out_en and duty_val match
the hardware even before iqs620_pwm_apply is called, as they're initialized
to zero as well.

I would be happy to add a comment in iqs620_pwm_get_state describing this
behavior; I should have described it there rather than the review history
(sorry about that).

However, you bring up a really interesting point about preserving what may
have been done by the bootloader. The device holds itself in POR until its
supply reaches a sufficient level, so there isn't necessarily a functional
reason to manually issue a soft reset from the parent MFD driver.

I could get rid of the manual soft reset, and then simply sync both out_en
and duty_val in iqs620_pwm_probe which would allow iqs620_pwm_get_state to
pick up any changes made by the bootloader prior to the kernel coming up.

The only problem is that leds-pwm disables the pwm at start-up, so the end
result is the same anyway. Regardless of the behavior of any one consumer,
however, I'm slightly inclined to go with the second option as it seems to
be less restrictive and more maintainable. Let me know if you disagree.

>=20
> Best regards
> Uwe
>=20
> > +	state->duty_cycle =3D DIV_ROUND_UP((iqs620_pwm->duty_val + 1) *
> > +					 IQS620_PWM_PERIOD_NS, 256);
> > +
> > +	mutex_unlock(&iqs620_pwm->lock);
> > +
> > +	state->period =3D IQS620_PWM_PERIOD_NS;
> > +}
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Kind regards,
Jeff LaBundy
