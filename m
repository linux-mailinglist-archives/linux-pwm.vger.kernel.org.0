Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001A613D2C0
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Jan 2020 04:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAPDeN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Jan 2020 22:34:13 -0500
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:6059
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728899AbgAPDeM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 15 Jan 2020 22:34:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktpwi7XtPSpF8SZWXfq+BhKXXE/um50wkDPfNJlYBtZTtzS+WQGzMVPNuZnA7+PaSsrk0inosAvJq7F4cdhiGl9B5vfsivm0dInpsjb0oJloruZVh0HVrpxWuwJwgbVHr4OMJW5AWND5qwIW5NvyHY9A6TXPNItJvy1vwgpK5JSsDT8eeWNlhnhwXy13g45Ufy40CmcT84CWWoVDX82iYL4tBZ8lDjhpoI86fsmUu50fWXvxr0Vd9R++Nta3ecytkQoWEx9ETiWsK1+TtJj5cAgENKtwKvxsvkTuZx45iWzkCzjF+xifWxDSh+vJZJV/K2+L6o7YL1oQBr76Uhr6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=342qBdhy1xLnhw+3+MmWh2y8qR9o6dZ/vjJqGb9/4P4=;
 b=cdVV9Ghdrv9HByn0i0z/A4RbBzHm5N+FfT8Cki3zER+XLr6XDg36sAJeyoTE2YFEK7ROcnvX455Tfo3Rg5ZhIKwAxXOjAUGQOpI2rThXeyekX563SD0As2R04d9vRNpS7kuMEf8Q/VTpu0ZggYQuCGyxP9DhseLtg+FA7bRNhBgD9LNrJdhmBTE5s4Ro+/Pk23fska/2EGckTOMr08HZrXNH9i/DkSuZdMA5jykVds3TKqO9pJPMX07RAsFdli2YUh9SUYEbYjKaxShkoh2ddvrA0wSKil8t15A7O0Qtl6QoHbLWudfM7qUuWdmFgIQOVR0SsDeBP2Z/GjlFUraUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=342qBdhy1xLnhw+3+MmWh2y8qR9o6dZ/vjJqGb9/4P4=;
 b=OhdDfGjmW4GA83kJrMGepsbIRmxKsaP9sKEVu++jfEUKf5DY8+XzyacweVOQjRNQqEKWRGVKvtKp5UVrX9RYNczfGLuSEVHKGAQhkfI+tbr9nrr61RWSHvDGQA0lNvdrUcv+NOB3IKCX7+/f+DvyJCO1IWMlGP+tN00PuJqI/zM=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5646.namprd08.prod.outlook.com (20.178.6.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 03:34:05 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 03:34:04 +0000
Received: from labundy.com (136.49.227.119) by SN6PR04CA0104.namprd04.prod.outlook.com (2603:10b6:805:f2::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend Transport; Thu, 16 Jan 2020 03:34:01 +0000
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
Subject: Re: [PATCH v3 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v3 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVxCrzh4C7ONAGT0GQryJS4hKCGKfp20QAgAFEdoCAAEQhAIABT16A
Date:   Thu, 16 Jan 2020 03:34:04 +0000
Message-ID: <20200116033355.GA8974@labundy.com>
References: <1578271620-2159-1-git-send-email-jeff@labundy.com>
 <1578271620-2159-5-git-send-email-jeff@labundy.com>
 <20200114080828.vv7ilksklt27ysh3@pengutronix.de>
 <20200115032945.GA6229@labundy.com>
 <20200115073336.2bhlu22toua3vnuo@pengutronix.de>
In-Reply-To: <20200115073336.2bhlu22toua3vnuo@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:805:f2::45) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19544122-e621-430e-5856-08d79a34ef6a
x-ms-traffictypediagnostic: SN6PR08MB5646:
x-microsoft-antispam-prvs: <SN6PR08MB5646157A25F41D3E60D9F277D3360@SN6PR08MB5646.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(34096005)(136003)(39830400003)(396003)(366004)(199004)(189003)(55674003)(1076003)(66476007)(64756008)(8886007)(55016002)(66446008)(7416002)(66574012)(71200400001)(508600001)(81166006)(81156014)(36756003)(16526019)(52116002)(6916009)(8936002)(26005)(2906002)(316002)(4326008)(5660300002)(956004)(7696005)(33656002)(86362001)(66556008)(2616005)(966005)(54906003)(186003)(66946007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5646;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3LjhGHUkZFupe5K6etXOmhlLkr56c9Rf2Vn0z1PvgXbMv6nwrmfnaAQErKPd4opYsM1saSFCv4e7fqtHVW9AhRaeexamxV2ZMlcJo7Jc2wVaA2sVGLsSnvsEf7/R075N+oe1z96Vz9489TanRsdB4jCg7eJlHuguRCMmzUznx0TVi1AQurJIuweVccIM8NcC86UfJYqeG0ovDFbs+udP5qMP829bVx78J1y38iRqJ5abJr10uXkVrL5F48w2JiPRQUo90IPfjh1Walk/7PsSHUfU2wZncrcxFzx08+A9/+1PQi1+mNtU036QiACDmMvd8p1X+FmaFZhOdp2MskO5o8Xx4Tf48so0SbzLsYyh/NQjGJaJh8xvpJ1DXZ63ht6wEoNDjTtRBv1kp1PKxlSC+Ubo7KkBZw73M1+sJYrBQRnF3ifPQg8v7hS8BaqgFTXPAr/opeMP6neUjxcjCs7/lUNoZKxVBmR2hcvJqGW3qC8VYi4NUi+wYCnFVHdW3G8nG9APUeObwrRlAaGmrZyFF7V3W2Ez8aQIL1sinULPlzc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E4497FD73A2BB84A8389E2B8F49D925D@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19544122-e621-430e-5856-08d79a34ef6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 03:34:04.7202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S0D7MFUWqC1dtEo56Xet2LveqNwb2Fa4B6HIjqrpovm6I7ndeHVzOQd0oQiOl8sdtRPyUR1Til79PZfmnsiT0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5646
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, Jan 15, 2020 at 08:33:36AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Jeff,
>=20
> On Wed, Jan 15, 2020 at 03:29:52AM +0000, Jeff LaBundy wrote:
> > Thank you for your kind words and thorough review.
>=20
> Great my feedback is welcome.
>=20
> > On Tue, Jan 14, 2020 at 09:08:28AM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Mon, Jan 06, 2020 at 12:48:02AM +0000, Jeff LaBundy wrote:
> > > I thought we dicussed having a comment here, saying something like:
> > >=20
> > > 	The device might reset when [...] and as a result looses it's
> > > 	configuration. So the registers must be rewritten when this
> > > 	happens to restore the expected operation.
> > >=20
> > > Is it worth to issue a warning when this happens?
> >=20
> > The detailed comments and an error message have always been in iqs62x_i=
rq of the
> > parent MFD driver. The pwm is only one of up to three sub-devices that =
subscribe
> > to the chain and must update their locally owned registers after the MF=
D handles
> > the interrupt and restores the device's firmware. I opted to keep these=
 comments
> > in the common MFD rather than repeating throughout the series.
>=20
> That's fine then, a comment that the parent driver issues a message
> would be great then.

Sure thing, will do.

> =20
> > > > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > > > +			       unsigned long event_flags, void *context)
> > > > +{
> > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > +	int ret;
> > > > +
> > > > +	iqs620_pwm =3D container_of(notifier, struct iqs620_pwm_private,
> > > > +				  notifier);
> > > > +
> > > > +	if (!completion_done(&iqs620_pwm->chip_ready) ||
> > > > +	    !(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > > > +		return NOTIFY_DONE;
> > >=20
> > > Is here a (relevant?) race?  Consider the notifier triggers just when
> > > pwmchip_add returned, (maybe even a consumer configured the device) a=
nd
> > > before complete_all() is called. With my limited knowledge about
> > > notifiers I'd say waiting for the completion here might be reasonable
> > > and safe.
> >=20
> > Great catch; this is theoretically possible. The problem with waiting, =
however,
> > is if the notifier is triggered right away during probe but probe retur=
ns early
> > due to an error (and completion never happens).
>=20
> OK, the error path would need to complete .chip_ready then and the
> notifier then check for this error. Indeed messy.
> =20
> > At this point, I think the best option is to simply cache the values wr=
itten to
> > IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE and restore them =
from the
> > notifier, which is essentially what is done for the IIO drivers in this=
 series.
>=20
> Sounds good.
> =20
> > > > +	ret =3D blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->n=
h,
> > > > +						 &iqs620_pwm->notifier);
> > > > +	if (ret)
> > > > +		dev_err(iqs620_pwm->chip.dev,
> > > > +			"Failed to unregister notifier: %d\n", ret);
> > >=20
> > > 	dev_err(iqs620_pwm->chip.dev,
> > > 		"Failed to unregister notifier: %pe\n", ERR_PTR(ret));
> > >=20
> > > gives a nicer output. (Also applies to other error messages of course=
.)
> > >=20
> >=20
> > I don't disagree, but this gives me some pause. If I made this change h=
ere, I'd
> > prefer to do so across the series for consistency. However, I am hesita=
nt to do
> > so at this stage in the review since several patches are somewhat stabl=
e by now
> > (unless there was a compelling reason from a functional perspective).
> >=20
> > Another reason is that there are many dev_err cases throughout this ser=
ies, and
> > adopting this very recently introduced functionality would make the ser=
ies even
> > harder to back port to the present lot of LTS kernels.
> >=20
> > Unless this is a deal breaker, I'd like to pass on this for v4. However=
, please
> > let me know if you feel strongly about it. In the meantime, I'll get st=
arted on
> > the couple of other changes discussed here.
>=20
> OK, being able to backport is a valid excuse. Consistency over the whole
> series wouldn't be one of my reasons, your mileage obviously varies
> (which is OK).
>=20
> This can also be done later. Conversion to this is on my todo-list (not
> at the top though), but if you beat me to it, I won't be angry :-)
>=20

Thank you for your understanding.

> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

I'll send out v4 in the next day or so after I finish some testing.

Kind regards,
Jeff LaBundy
