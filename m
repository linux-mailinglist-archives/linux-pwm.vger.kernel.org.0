Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B68285725
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Oct 2020 05:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgJGDig (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Oct 2020 23:38:36 -0400
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:6373
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbgJGDig (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Oct 2020 23:38:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPjIw77wqA6rQ7r42kqtrsuvJ8WJLwIXQKJb01eEvn6gH998YlBd69QOrZmOqi9derUfijGSDnsKdj7OxI3liyxv9H2OdMHzBTerpdefeHClwjX2VM/sPAnv0vTrh0lUZ57AY3PV+DHq+dHHyprJH6UnNWVhjggHsX9qZdnXrnjb+nvFPldDzc24jdosf48FwbAu3GVGHcepPE6WV9R7GierOd5ZZwejcIj78XDQbNEdkGi/49YskKKJZ/1a12R2CNjxuWI7dGOrYS5R6qJMqv7ZPMVHA3hDsIrzZZyGnALDtcyuopdtBhwq2gR0602ThtineIA434WtpkreaB/7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmdJXpH+QuLU3HRTbQ5xGn0KmliMiR+6xZpCscNTlH8=;
 b=A/uNAlrAJjyT+HinOFdtse+u3iEDZO3L6XjTaytqNt5mOF3wKQlsxa4/a/6aTVrvqtbZ5Q56A+ccRI+uRUWMjt8UEHi1BDMfxQB3OYbBV2WI4h28p+52XyZEnNoYhTCKmHKZIZES+qHqSpTBQ6M+XLq5v8gf+WuTngLOTdwBeaFVdPujki1g3YmStxgmGZRLU1CM1lKVMc1KwsslrEOv/DnpmYKyDWG8Lvkj7jVT+9pTZYql8aQBcLbYgHZ0DnBZMVPk9a7K18c7IbSU/T4jx74Cn9dBEPA2x8HDK0MJzorCq3qgh/iY3TC0yY88C5sRxNQMB/uNQPdkIl7oyKk0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmdJXpH+QuLU3HRTbQ5xGn0KmliMiR+6xZpCscNTlH8=;
 b=ZENTqp384Hj5gqA1fdUsOhtnmdnZKP7D7/NaT77ARuVp7B08Gkg04fD/+NaF4LlCck4QxMp7ISC+t+TTN16B/CDK7PoeSrA59Ll3ncpcPshedIPcMX5i5gDxAo4wmXviFEDCHO9K4vQRbqSV5zC6QxIcYnIdjBRCDLCBta9uts8=
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB2524.namprd13.prod.outlook.com (2603:10b6:5:ca::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13; Wed, 7 Oct
 2020 03:38:32 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3455.021; Wed, 7 Oct 2020
 03:38:32 +0000
From:   Sagar Kadam <sagar.kadam@openfive.com>
To:     Rob Herring <robh@kernel.org>
CC:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        Yash Shah <yash.shah@openfive.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: fu540: prci: convert PRCI bindings to
 json-schema
Thread-Topic: [PATCH v2 1/3] dt-bindings: fu540: prci: convert PRCI bindings
 to json-schema
Thread-Index: AQHWlnXeXXLTxHlPR0agfuqgQBIFramK9AgAgACUlnA=
Date:   Wed, 7 Oct 2020 03:38:32 +0000
Message-ID: <DM6PR13MB345196DCD0894CD0C77DCFC6970A0@DM6PR13MB3451.namprd13.prod.outlook.com>
References: <1601393531-2402-1-git-send-email-sagar.kadam@sifive.com>
 <1601393531-2402-2-git-send-email-sagar.kadam@sifive.com>
 <20201006184244.GA2610231@bogus>
In-Reply-To: <20201006184244.GA2610231@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [116.74.151.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7169d408-cc5a-414e-c4a0-08d86a7276fe
x-ms-traffictypediagnostic: DM6PR13MB2524:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR13MB25244DF2231D452805E983E3970A0@DM6PR13MB2524.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HbY5C1zHFTvz2Gnra3wtAI5JFk/PUuogKW6aGdLPb2XqJDgRWNyn8qv+iGKISelPODXvRsHghE7oud5GSpjvDF+TY9HCVg+QR6sEv5xwNoBsjya9hGDhFhsgUdCNjVDwqpuxvxFU0FvJr99DphWuKj0HdP6rmb8FmNsEz8E5Q6tPJoV8FOP5mH6mVlNmeFGluhg1VHL77ykaFV6pwzLbjevSZAAY+IQUJJWPqXR5TF0IK9+c6H9JSA8sARpqNtN9gKNGH27RQ2cFqp8V9dxos25cc4vhZN2TCM6gLpZPTp4qSkqE346+3M2AEbylua0hAncHkdlwdzcdehTiD4ENKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39850400004)(8676002)(7696005)(4326008)(86362001)(478600001)(44832011)(26005)(55236004)(6506007)(53546011)(33656002)(186003)(9686003)(64756008)(8936002)(66446008)(55016002)(316002)(71200400001)(6916009)(54906003)(52536014)(5660300002)(66556008)(66476007)(7416002)(2906002)(66946007)(83380400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nby6Dx2z2LLxqwlFCU7sknVZUM4Hc1gOPxs5KAHXVt/09QOK4C9sl7HKBM1sRZwIuYJCimwJQZK6tHzdPDZO5b3A7GPf/pNh/xd+4CPxAC6zgf9Q77De1oDn43qnN1q4qLUCgOlXjpGrkGoHAfz3p6JPiGY96XLig9Hn1iZYkREpj/R8b9XGfyFn5Qf0YlZ68kBHNM6wZsRZoO3bzqLqeCCPtn+dEzSYLzLPrKahtHMfffW4ulzq1gc3+0OEgpTpnkT4Oy/PzGmWvft7XK7z3yWrfiR8Rt/DA8k19Fz4C466I5DsM5fU+EusCfq9q6bnLvXHne4ElFSXPcCHKWRHyfqH2wnpvKgaK5IHp3N6B8sobyRN1u5To0BJ9phGGlInDkLkaf+p/kikR2xuHt2g5dtIXnVzmC32c2QODfXvNtACFj/2Yd7qljxH0zVlIMmXkauDN5UN6ISTkR2QSFhfLf0JY07aImQo0DaD9TbHhGqI1UG6KFrRvPEtOXbzYJGk7DY1HyXEpQ3nS/yP/PuFTBWB4JmcTR2BLn+n66tMLAK01NGau2vCcHgK6Jm8OjCO28XnFq4/i+ewR+b0bR0YmvGbnPY6dnKmIsFRPmWiyMTxQ5EcPobY3rx2wWCoyBuG/WQipqQUcx1lW/nVExP+fQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7169d408-cc5a-414e-c4a0-08d86a7276fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 03:38:32.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lX4sV84yOcFmF7Fx9F5sCnrQcCK6nSghDpmgUrOR42fApFl6MlJqVRVxeIhDGGc6Y36NVBHn47MSbhShQp80nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2524
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, October 7, 2020 12:13 AM
> To: Sagar Kadam <sagar.kadam@openfive.com>
> Cc: aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org;
> tglx@linutronix.de; linux-pwm@vger.kernel.org; palmer@dabbelt.com;
> jason@lakedaemon.net; Yash Shah <yash.shah@openfive.com>;
> thierry.reding@gmail.com; lee.jones@linaro.org; u.kleine-
> koenig@pengutronix.de; robh+dt@kernel.org; Paul Walmsley ( Sifive)
> <paul.walmsley@sifive.com>; linux-kernel@vger.kernel.org; linux-
> clk@vger.kernel.org; maz@kernel.org; mturquette@baylibre.com;
> devicetree@vger.kernel.org; sboyd@kernel.org
> Subject: Re: [PATCH v2 1/3] dt-bindings: fu540: prci: convert PRCI bindin=
gs to
> json-schema
>=20
> [External Email] Do not click links or attachments unless you recognize t=
he
> sender and know the content is safe
>=20
> On Tue, 29 Sep 2020 21:02:09 +0530, Sagar Kadam wrote:
> > FU540-C000 SoC from SiFive has a PRCI block, here we convert the
> > device tree bindings from txt to YAML.
> >
> > Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> > ---
> >  .../bindings/clock/sifive/fu540-prci.txt           | 46 --------------=
---
> >  .../bindings/clock/sifive/fu540-prci.yaml          | 60
> ++++++++++++++++++++++
> >  2 files changed, 60 insertions(+), 46 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
> >
>=20
> Applied, thanks!

Thanks Rob for applying these patches.

BR,
Sagar
