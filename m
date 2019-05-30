Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBCAD2FA08
	for <lists+linux-pwm@lfdr.de>; Thu, 30 May 2019 12:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfE3KNX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 May 2019 06:13:23 -0400
Received: from mail-eopbgr1410124.outbound.protection.outlook.com ([40.107.141.124]:46911
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfE3KNX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 30 May 2019 06:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdAMWJOQJv2wMQ08r2+yvmc1bQfc7QvLgewa/Fw8K8s=;
 b=Ayzxh7Y4syAuwRLUbtOfjyXIoS1PVCHooMHdveuzhJujSneV4RhK8IrwWhnvcYVlr38IYJWkN9oOhX5G19q2Pm6xImGVUH7RswSnT/rTAZ1Yhb+/uK4+bG5fs1vsm4nXjFFYYQe9LYEyNbpoXsl8dRrvPJ7ki2Yvj1hEJ1LajA0=
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com (52.134.247.150) by
 OSAPR01MB3777.jpnprd01.prod.outlook.com (20.178.102.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Thu, 30 May 2019 10:12:39 +0000
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com
 ([fe80::4597:5353:28fb:cfd8]) by OSAPR01MB3089.jpnprd01.prod.outlook.com
 ([fe80::4597:5353:28fb:cfd8%7]) with mapi id 15.20.1922.017; Thu, 30 May 2019
 10:12:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/4] pwm: sysfs: Add suspend/resume support
Thread-Topic: [PATCH 3/4] pwm: sysfs: Add suspend/resume support
Thread-Index: AQHVFfOGU15czZP0GUGB5Ku4l2S3bKaCG6OAgAFWYEA=
Date:   Thu, 30 May 2019 10:12:39 +0000
Message-ID: <OSAPR01MB308953DA7219D38BDD25A712D8180@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559116082-9851-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190529133817.GB17223@ulmo>
In-Reply-To: <20190529133817.GB17223@ulmo>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9febb645-8b42-4f49-afaa-08d6e4e758ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSAPR01MB3777;
x-ms-traffictypediagnostic: OSAPR01MB3777:
x-microsoft-antispam-prvs: <OSAPR01MB3777B245F1B3DCABE70F964BD8180@OSAPR01MB3777.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(189003)(199004)(305945005)(81156014)(7736002)(81166006)(8676002)(6506007)(71190400001)(14444005)(73956011)(71200400001)(6246003)(8936002)(74316002)(2906002)(68736007)(7696005)(66446008)(66946007)(76116006)(256004)(186003)(4326008)(64756008)(66556008)(66476007)(5660300002)(229853002)(86362001)(15650500001)(52536014)(6916009)(486006)(11346002)(66066001)(99286004)(55016002)(316002)(33656002)(26005)(476003)(446003)(9686003)(6436002)(6116002)(102836004)(25786009)(14454004)(53936002)(478600001)(3846002)(54906003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB3777;H:OSAPR01MB3089.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a32/gffclRGrV4oOiI9SXAvNwybeHtDVdq51ezgN9gzV7UIxMeAGSj3DcfDSMSdmGrDtQKikwh1P2gzdPB+G5wthEQNjuf6nB6tZlSKhQVtKdlAxmklyIYWHJVIUDXk/CTlPhLsdoyVkpK/qZk3f9u1H8QvZS8WaLG6FWJOPNtlGYOG2cXOVM/hRQrIYrNBidMPTwakkKIGu5Kr6Im/VdR15lJiY/S7IwlxAZR1rcVv1uzR5anRnewGx9hjnrynCgNoAVY1+wcZ+yPVi63h9gn+evfhW99aUn8AH8Thg9IUuWoeIfdgz729JkIddNaTUCKbsDCCVCFqsGM9EI2U+Pu/Bf8/RVAltbHxMrzHvOqdIcRPDShJIQgdUF7wK0dLpw8rHtX9nTKESLfx65Bzu9Do6X3V8QXyfYTAHRoy39Ic=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9febb645-8b42-4f49-afaa-08d6e4e758ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 10:12:39.4015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3777
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

> From: Thierry Reding, Sent: Wednesday, May 29, 2019 10:38 PM
>=20
> On Wed, May 29, 2019 at 04:48:01PM +0900, Yoshihiro Shimoda wrote:
> > According to the Documentation/pwm.txt, all PWM consumers should have
> > power management. Since this sysfs interface is one of consumers so tha=
t
> > this patch adds suspend/resume support.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pwm/sysfs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> > index 7eb4a13..72dafdd 100644
> > --- a/drivers/pwm/sysfs.c
> > +++ b/drivers/pwm/sysfs.c
> > @@ -18,6 +18,7 @@ struct pwm_export {
> >  	struct device child;
> >  	struct pwm_device *pwm;
> >  	struct mutex lock;
> > +	bool enabled_in_suspend;
>=20
> How about if we save the complete state here? Something like:
>=20
> 	struct pwm_state suspend;
>=20
> Or similar? Then we can just pwm_get_state() into that and then disable
> the PWM like you do.

I got it. I'll fix it on v2.

> >  };
> >
> >  static struct pwm_export *child_to_pwm_export(struct device *child)
> > @@ -372,10 +373,73 @@ static struct attribute *pwm_chip_attrs[] =3D {
> >  };
> >  ATTRIBUTE_GROUPS(pwm_chip);
> >
> > +static int pwm_class_suspend_resume(struct device *parent, bool suspen=
d)
>=20
> I would prefer if these were separate functions. I think the kind of
> conditionals that you have below isn't worth the few lines that you may
> save by fusing suspend/resume into one function.
>=20
> Also, if you store struct pwm_state suspend during suspend, then both
> implementations will end up being fairly different, so reusing the code
> isn't going to be much of an advantage.

I got it. As you said, separate functions are better for the code readabili=
ty.

> > +{
> > +	struct pwm_chip *chip =3D dev_get_drvdata(parent);
> > +	unsigned int i;
> > +	int ret =3D 0;
> > +
> > +	for (i =3D 0; i < chip->npwm; i++) {
> > +		struct pwm_device *pwm =3D &chip->pwms[i];
> > +		struct device *child;
> > +		struct pwm_export *export;
> > +		struct pwm_state state;
> > +
> > +		if (!test_bit(PWMF_EXPORTED, &pwm->flags))
> > +			continue;
> > +
> > +		child =3D device_find_child(parent, pwm, pwm_unexport_match);
> > +		if (!child)
> > +			goto rollback;
> > +
> > +		export =3D child_to_pwm_export(child);
> > +		put_device(child);	/* for device_find_child() */
> > +		if (!export)
> > +			goto rollback;
>=20
> Con this even happen? I have a hard time seeing how.

Oops! This condition is unnecessary. I'll remove it.

> > +
> > +		mutex_lock(&export->lock);
> > +		pwm_get_state(pwm, &state);
>=20
> All of the above is shared code, so perhaps it'd be worth putting that
> into a separate helper function to achieve the code reuse that you
> otherwise get from sharing the function.

I got it. I'll make such a helper function on v2.

> > +		if (suspend) {
> > +			if (state.enabled)
> > +				export->enabled_in_suspend =3D true;
> > +			state.enabled =3D false;
> > +		} else if (export->enabled_in_suspend) {
> > +			state.enabled =3D true;
> > +			export->enabled_in_suspend =3D false;
> > +		}
>=20
> This in particular is what I mean. I think the two levels of
> conditionals here make this more complicated to understand than
> necessary.

I think so.

> > +		ret =3D pwm_apply_state(pwm, &state);
> > +		mutex_unlock(&export->lock);
> > +		if (ret < 0)
> > +			goto rollback;
> > +	}
> > +
> > +	return ret;
> > +
> > +rollback:
> > +	/* roll back only when suspend */
> > +	if (suspend)
> > +		pwm_class_suspend_resume(parent, false);
>=20
> And then there's stuff like this where you need to explain what's going
> on just to save a couple of lines of code.

I'll add a comment on v2.

> Other than that, looks really nice.

Thank you for your review!

Best regards,
Yoshihiro Shimoda

> Thierry
>=20
> > +
> > +	return ret;
> > +}
> > +
> > +static int pwm_class_suspend(struct device *parent)
> > +{
> > +	return pwm_class_suspend_resume(parent, true);
> > +}
> > +
> > +static int pwm_class_resume(struct device *parent)
> > +{
> > +	return pwm_class_suspend_resume(parent, false);
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_clas=
s_resume);
> > +
> >  static struct class pwm_class =3D {
> >  	.name =3D "pwm",
> >  	.owner =3D THIS_MODULE,
> >  	.dev_groups =3D pwm_chip_groups,
> > +	.pm =3D &pwm_class_pm_ops,
> >  };
> >
> >  static int pwmchip_sysfs_match(struct device *parent, const void *data=
)
> > --
> > 2.7.4
> >
