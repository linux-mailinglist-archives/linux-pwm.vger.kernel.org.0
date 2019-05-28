Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89C52C0E7
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2019 10:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfE1IJX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 May 2019 04:09:23 -0400
Received: from mail-eopbgr1410132.outbound.protection.outlook.com ([40.107.141.132]:54705
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfE1IJW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 May 2019 04:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiFGUyM85Q58wWEWo6VmidSNMTJI0aR5TdLg/trK1JA=;
 b=XtZtMN1WQXM9ui+HvswlLp0Q+1s6okdoPiK7yI5e6k3I6t0a+7qBGSfc/kqYS45DIEm625mEImPOWZewjJak0l92drcudLJaDFYMrkT480DLWn96VSBMgMth8j3Ysi4hfwc7iLu1KpXc/hq8u5oAK2Wxq/xmj4glcqvK1iugITI=
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com (52.134.247.150) by
 OSAPR01MB2145.jpnprd01.prod.outlook.com (52.134.236.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Tue, 28 May 2019 08:09:17 +0000
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com
 ([fe80::4597:5353:28fb:cfd8]) by OSAPR01MB3089.jpnprd01.prod.outlook.com
 ([fe80::4597:5353:28fb:cfd8%7]) with mapi id 15.20.1922.017; Tue, 28 May 2019
 08:09:17 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        hideo inayoshi <h-inayoshi@jinso.co.jp>,
        "na-hoan@jinso.co.jp" <na-hoan@jinso.co.jp>,
        Cao Van Dong <cv-dong@jinso.co.jp>
Subject: RE: [PATCH v5] pwm: renesas-tpu: Add suspend/resume function
Thread-Topic: [PATCH v5] pwm: renesas-tpu: Add suspend/resume function
Thread-Index: AQHVFDMg6ZD9P64qcEWd+8ju6SEvhaZ/BX2AgAEpnEA=
Date:   Tue, 28 May 2019 08:09:17 +0000
Message-ID: <OSAPR01MB3089DB21780B1236507E10D3D81E0@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1558923757-9843-1-git-send-email-cv-dong@jinso.co.jp>
 <20190527141741.GC7202@ulmo>
In-Reply-To: <20190527141741.GC7202@ulmo>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4b85d6b-54b8-4c9c-b85e-08d6e343c7d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSAPR01MB2145;
x-ms-traffictypediagnostic: OSAPR01MB2145:
x-ms-exchange-purlcount: 1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-microsoft-antispam-prvs: <OSAPR01MB2145BE0E4AAA647CD1F839C4D81E0@OSAPR01MB2145.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(26005)(33656002)(446003)(186003)(6506007)(256004)(476003)(76176011)(486006)(53936002)(55016002)(99286004)(102836004)(66066001)(6916009)(6246003)(6306002)(9686003)(54906003)(316002)(3846002)(478600001)(6116002)(966005)(14454004)(6436002)(25786009)(66556008)(66476007)(11346002)(4326008)(8936002)(68736007)(7736002)(305945005)(81166006)(8676002)(81156014)(15650500001)(86362001)(5660300002)(52536014)(71200400001)(71190400001)(2906002)(229853002)(66946007)(73956011)(66446008)(64756008)(76116006)(74316002)(14444005)(7696005)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB2145;H:OSAPR01MB3089.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y8eSVmgTOVNy4aTmUaHPKDScfxAmDijUwwLAVV59kKm7tI2uVwME3zPtKah4mlPhtm5D7FqQgp1o/Zmlen69NDRLGTw7B5O9eskq6CTpJWo6gTbcSBsexxRxQCCjXzYH8pfzHb2QXGn6TcNkx00+Tvtj4K/P6/JUMRVLFu0ngWtoc8K+WmlB8EzDoJ56L+efblgWUnPMr8R8UhBR1ZUNmat3LEHzQwnzGztj5vgllrz57j9bE85L39cYYGXKDe55rNHAYZljfJ6GXDBfy2UM6IBrzeqUVPcH4bywPRqn3RFTo7Uvm0eOIXr0dal4xP9IzrKl57P0e0dO8TddHd75DgDcJ+PgJ5FSF3hTnfJvOXLmpuyVpeOypV0PjnCvFsuq/DfDtBXbSdgf3zIiC7k37UB2PTn8MDoXMjL+cSifd1U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b85d6b-54b8-4c9c-b85e-08d6e343c7d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 08:09:17.3026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2145
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

> From: Thierry Reding, Sent: Monday, May 27, 2019 11:18 PM
<snip>
> This has been discussed before, but this really shouldn't be done in the
> PWM driver. Consumers should really be reconfiguring the PWM upon resume
> as appropriate. This is the only way to ensure that everything is
> resumed in the proper order.
>=20
> Most, if not all, consumers already implement suspend/resume that way.
> sysfs is the only one that I'm aware of that doesn't.
>=20
> Since you've been using sysfs to test this, things are slightly more
> complicated (i.e. we don't have a consumer driver in the conventional
> way). However, you should be able to solve this by implementing
> dev_pm_ops for the pwm_class.

Thank you for your coment! I'm interesting about implementing dev_pm_ops
for the pwm_class. This is because you talked related things on other
pwm driver (pwm-rcar) on the following email thread.
https://marc.info/?l=3Dlinux-renesas-soc&m=3D155169831832176&w=3D2

So, I'll try to implement it and tested on the pwm-rcar driver.

Best regards,
Yoshihiro Shimoda

