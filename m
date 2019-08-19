Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1991CEC
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 08:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfHSGQe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 02:16:34 -0400
Received: from mail-eopbgr1410097.outbound.protection.outlook.com ([40.107.141.97]:38533
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfHSGQe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 19 Aug 2019 02:16:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dImzpA4/wZPBv/I+MBf8Q9ytKLISWvQOYmJbAOp0ARLpPUs4PMlO049XMViWzvyyuXDVZ42NUdxZx4NGXwLVKzSYy70PsHSH6wvjTuKhAseRnyTd67zuPYIOMihk00fbalsBHUmVUe1DPOqheU2EQH3PsE3jPiaVcD7VQPyTKSaQ5c7aSaLQJsVHMeyytgKcMczaxtiHD2GN1U5X0s48C9rZTPp0SORRHA0O5iKrtorIhzHN52XXUSfndY9OZbfzcd5ew8Vne6bVOiheDIgXz/9A+cnqVFshLmjrGfV568PzXR7aQlT/bGH7rSMTTmR+dcMbAzzFLgORBhM43dzDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGG3WRuOv+pkWhlhHZVi9x/zSHR1nelBYh7NsLmEINc=;
 b=Ndh0n04x54DiBo9CPsgLB9zma478rQ+ZHuAHFr/vqFDig0QweJWeWunmT74DnduGwh2z8eqHe+AXrDBcwsP2Mo+t0lFGDtwYBjJMWIOPvnxGPhIrdNYizgiaUp6nSYamkgkeSkSfGxXdJGKVVNPPtxBsvQ9iWwZVpp/3Y+GldKrbClYbXFgfjtybCcrAWCjSXVkZSsp/Ge7SutrzK11eEEUqBmyhZwvUiTiHRqU0zZmgqVfSRrt8NZ52AaDTjgqLRH/gR5gQO37D9nqvD3Fv1iJPQj/yY+ODfKPdoswPCF2uu5IGRv+YlSpduJ9qvAm6UKobSPasldY7Wj4CQup27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGG3WRuOv+pkWhlhHZVi9x/zSHR1nelBYh7NsLmEINc=;
 b=PhW2iCKAJYd5Hr7wyBjedtek9EN+Hz6ucrhBDH28LaZz6YGT5CQnZgkyc/kMgLJD3/JVaT4HN21Xf+30nuDU+9pFo1KV+o3XqXWeu3Vvj9oGTtnobfrwLkzbRsXEIdOYkRddrGg3nM/h5PXLEEBVePl0PanSeKOdigvN67+ee/4=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4685.jpnprd01.prod.outlook.com (20.179.187.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 06:16:30 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 06:16:30 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
Thread-Topic: [PATCH v2] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
Thread-Index: AQHVTbQl7fZQFZBEpkqGeM42hHIRfqbxA3YAgAGFy4CAD4YrcA==
Date:   Mon, 19 Aug 2019 06:16:29 +0000
Message-ID: <TYAPR01MB45440E2AE2618955F27E9632D8A80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1565246333-2185-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <b528827c-1744-901e-b795-ddd1aaf828d3@cogentembedded.com>
 <20190809091047.2hrlt245ssjoztfn@pengutronix.de>
In-Reply-To: <20190809091047.2hrlt245ssjoztfn@pengutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9d5a1ee-19a7-4724-9934-08d7246cc6a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB4685;
x-ms-traffictypediagnostic: TYAPR01MB4685:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TYAPR01MB468588BCD8BC0B03E932A605D8A80@TYAPR01MB4685.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(9686003)(478600001)(33656002)(102836004)(110136005)(54906003)(3846002)(6116002)(64756008)(66946007)(5660300002)(4326008)(76116006)(52536014)(66556008)(66066001)(66476007)(66446008)(25786009)(4744005)(6246003)(53936002)(966005)(316002)(2906002)(14454004)(71200400001)(71190400001)(446003)(486006)(476003)(99286004)(305945005)(8676002)(76176011)(229853002)(8936002)(11346002)(81166006)(256004)(81156014)(74316002)(7696005)(26005)(7736002)(55016002)(186003)(86362001)(6506007)(53546011)(6436002)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4685;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TcoW0U8AAaEeycwwuFDnAh42FexqzC8NSVdZ/X+MtPUoL4iw1Hzz56F7RnOR8V8ZgD5sZvAJCG1uj/jZN5y/r8gpo1jFp0110CdTkqadMDzE0LiTYZ10cEhHabqAFHzxt+aoGFz8CSf8cDsfRyjx3IBdLCl7lPkTJGfKOIYVGwWrtMGsLvwbVV9vUjiazleXb+iLw6VGI/U2lg68knPrLIPjsb8dzfz+v5lu6uD0qZOgU66Vgh63LYqW1E/s9Xy4ecnRwf+Yf23/XuhGCqn2SU41U/5p3bXqMWQRETkROuxtAjcqhs8I4Qewdz0zV1zMxyBoJl1rPym+U8451VVN8dSxVDpcLuBWWqRX+qR15Zax4Fxg0bQe3OKwIUbsD6I1IcGl/3K0Am+Ql+4YZ8Jp/Hm3Rmo8AjE/cUWbBD7oDxc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d5a1ee-19a7-4724-9934-08d7246cc6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 06:16:30.0144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcwyzWu7T3hK8y7kgaoBsxu50qTmJzHDFDHz/TofFuB5IG92d995xLMOCKD6YVQ6LF49jrT6XBNsdhzU8+qFYRhylU3VbdZnPFBoG3NxhHlqq0pOkQQ2Fy11Hu80VYsY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4685
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello!

Thank you for your review! And, I'm sorry for the delayed response because =
I had a vacation.

> From: Uwe Kleine-Konig, Sent: Friday, August 9, 2019 6:11 PM
>=20
> On Thu, Aug 08, 2019 at 12:55:40PM +0300, Sergei Shtylyov wrote:
> > Hello!
> >
> > On 08.08.2019 9:38, Yoshihiro Shimoda wrote:
> >
> > > Since the rcar_pwm_apply() has already check whehter state->enabled
> >
> >    Checked?
>=20
> and "whether"

I'll revise it.

Best regards,
Yoshihiro Shimoda

> Best regards
> Uwe
>=20
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
