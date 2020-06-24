Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D4C2079A8
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2020 18:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404961AbgFXQ4h (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 Jun 2020 12:56:37 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:48537
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404124AbgFXQ4h (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 24 Jun 2020 12:56:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOrQZTKp2PzToUSVlSdRoM1CyRuYqD/A6PeDkPfp4MYpZkMBhYh3CP8D7ONajfsiP6TZt7kRunaytZzh4GcfXea7iC4Imgkef54PCVFTwaCXUPiWwL1igRChwvPgyA2AobQjP1KrR6d5hqKe39ZCVx7mpcgf3RQd8ieVM19RgrAbQtZEjRiWN3II5wEQyN1mu+fLbX0T2dA3BDx3NnN/jqQluy/R7DsfBm9fUYLIQAVco8TMRAa9MCaGSybnjGNM2fUj56RcQK9wDDBXHoVAsPhGxbFa1FooGImZxvPzGWkV5cdFPjQMGi5QbezW2BDUvt+X6r3wN6TWMfaFYTKQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG+twrj78r7kIbG+AHcuDRJtBDUIYS1DHHPV9XwBvzQ=;
 b=AsGZ3X56FSqNBmfBXaRW84/s4CQWbFugCH7mWwroZXWUMzdJ0pPH2hX9uHeqWhyaSKNS8Bttd+20Rm+8we51WGkpUekyCjRAGXGrsz2zn6XFdDmWHnB1ULtR3hWKDQpNOIRf04mWdPFvgzKc+eDSia/txe0fHZSkK8q4QqhH2l33ZFBTsi3pUcAzZQvfHWGosL5habj5+D9yel5arcXz65w6idez2W+aN/9iCiXxn/rEMxgml1sVoocv0xR5Zzse4kYl/QNPzaRdOM4tky3FxVtUrGydiJeAcXAuQiVYvu20woI+yheZbVhvAoa4jls1SETXwIvCG2c4eoRxNizE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG+twrj78r7kIbG+AHcuDRJtBDUIYS1DHHPV9XwBvzQ=;
 b=W6Apbzyu8CbApelejTVgGDGkls8G2ekV6et8+IYiRbThUAUQxunxoxtfjqX0qK7JupZE5JBo6EhBLDDux7okLBxipm54hhpcAOtTjQx704KmSj4Kzjm27zJGBfVTPuWbINLzH5xytd5EoHB9tIov+LbvqVCCfh6THW0usr4r/Ls=
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11c::13)
 by DB8PR10MB2892.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 16:56:32 +0000
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56]) by DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56%8]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 16:56:32 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Roy Im <roy.im.opensource@diasemi.com>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Thread-Topic: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWQwzBfFR7uhdm1kyQ3q9kXzA/B6jmUoyAgAFmjgCAABn+AIAAIjUAgAANiACAAAQ98A==
Date:   Wed, 24 Jun 2020 16:56:31 +0000
Message-ID: <DB8PR10MB3356FB869A14EA88AFB40F4885950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1592221223.git.Roy.Im@diasemi.com>
 <135761fd309eb9424faeb631b6e6c66147b57666.1592221223.git.Roy.Im@diasemi.com>
 <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
 <DB8PR10MB3356697B41C0FB97F5FD330185950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
 <20200624133726.en7q52rpdtzvhajz@taurus.defre.kleine-koenig.org>
 <DB8PR10MB3356AFC38358881B471E76A285950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
 <20200624162818.zjdtdlocxxndbsld@taurus.defre.kleine-koenig.org>
In-Reply-To: <20200624162818.zjdtdlocxxndbsld@taurus.defre.kleine-koenig.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bc84590-6738-4aff-304d-08d8185f8c33
x-ms-traffictypediagnostic: DB8PR10MB2892:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB28928C69223DE0D67C6DA179A2950@DB8PR10MB2892.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fmbBzVBMgMEJi/MjE6uazOflatvKEUta82DyXdEFu+lDW4evANxjz1tuRLOBASB91RJoFvcpE9scqwhBvemCJDPftr9KqiOPa0YL1okv9AXPFJZOZI/1x2zfPUVLbASncPCfdTwXJ4xmRFh/9IBgKY9ohH2gOKq7UbbdXhDJuJWjMhxCNfyOJHS1AFVlnA7UChShH3Acu0xMOQNbwYSOn8xdpgMwtN7YLoyPXose/dojwXRwcJmOdCzMpnr/LdPbcZzNn8wNtVzwL5DwBnnAtuVRcZCmG7FnnPsTQAuV3dJ8tKBhg8tqhPLs3mTrUGyLCR/Oh0ydFi8aD8z0uPxdo1V8Sf9dhmCysAtU7CYXBdfPIXXNglTsFPNwJ/GW0cp7FF4Az9YXHGMHgIIYRQjDyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(186003)(86362001)(110136005)(26005)(7416002)(66574015)(5660300002)(8936002)(54906003)(33656002)(4326008)(66476007)(66556008)(64756008)(66446008)(7696005)(83080400001)(76116006)(66946007)(83380400001)(71200400001)(966005)(316002)(478600001)(9686003)(2906002)(52536014)(55016002)(8676002)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: B9olAMvYfuU6hqSNntU4x/Tc/IPjJQB1a0EKepBPt8L2ypp/N6WHf3mXQ6cOvjx7WfF6d5gZjqAc1vTLJTKMNuVyNs8DdoZASkXeEMu7XRSRM+QAJNbM0wyuUEzzc9hVxybJnZh/Mvn/V+qntVui4kPYn+u3O0WKPKEHRFMDFsGAQ88UlNGO1NpauhJ1KYqb0MTAfzYBYCsB84u+bZE6VQMgD/iUDEHtcuP2ztaJ/oKmQC1ALc2/ttCkmGG8nFOxfk2bZlp7Moe+UXgUV4jN8nDEcqbD4wYIrVZQwjoa3ioKfwW18UPo2HoKv+biiQR3leMTr2czQRwSQnELRtExGDR0kL5QnUKQ1ytB3HxamGxGWjPY1dGxJtJpmYg+WjkZ0NcDNP6KICM6W9/nnqyNBClr75bUtt7asUDqpC5boAFg1KMM+rcr82V12pLm8mrrmYKE5OGjTGs+JrKHx3awslU7/wj5WImGUynDwlv90L4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc84590-6738-4aff-304d-08d8185f8c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 16:56:32.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgPozEXh/06tL61Kr5eKW4PYwUfcNjyv28kr+M2GsOqUYnT64rH9O0UBR70WCt2D87y1ZcQI2R1lQfaXDGK7bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2892
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, June 25, 2020 1:28 AM, Uwe Kleine-K=F6nig
> On Wed, Jun 24, 2020 at 03:39:52PM +0000, Roy Im wrote:
> > On Wed, Jun 24, 2020 at 10:37 PM, Uwe Kleine-K=F6nig wrote:
> > > On Wed, Jun 24, 2020 at 12:04:24PM +0900, Roy Im wrote:
> > > > 		period2freq =3D 1000000 / state.period;
> > > > 		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > > > 		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > > > 			dev_err(dev, "Unsupported PWM frequency (%u)\n",
> > > > 				period2freq);
> > > > 			return -EINVAL;
> > > > 		}
> > > > If you look ok, let me update this so.
> > >
> > > looks fine.
> > >
> > > Note that you don't need the division if you check for:
> > >
> > > 	if (state.period > 100000 || state.period < 4000) {
> > > 		...
> > >
> > > (maybe the compiler is already clever enough to get rid of the divisi=
on for you, but then the check is:
> > >
> > > 	if (state.period > 100000 || state.period < 3985) {
> > >
> > > because of rounding errors.)
> >
> > OK, you are right, that will be better. So let me change that as below
> > if you look fine.
>=20
> I look fine, the code however is wrong. :-)
>=20
> > 	/* Check PWM period, PWM freq =3D 1000000 / state.period.
> > 	 * The valid PWM freq range: 10k ~ 250kHz.
> > 	 */
> > 	if (state.period > 100000 || state.period < 3985) {
>=20
> You want 4000 here ---------------------------------^^^^, don't you?

Yes, it is now based on period, not frequency. You are right.
4000 is correct now. Thanks.

>=20
> > 		dev_err(dev, "Unsupported PWM period (%u)\n",
> > 			state.period);
> > 		return -EINVAL;
> > 	}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
