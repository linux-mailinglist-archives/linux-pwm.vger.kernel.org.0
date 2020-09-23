Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2576275EB7
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 19:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWRdl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 13:33:41 -0400
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:33504
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbgIWRdk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 23 Sep 2020 13:33:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+Bpu01WgwY8rUVObR7whTusuj5wQckdiOWZIN971E1V9F3+bpwJf2vyk3IESA0OeGRqcO0SA4NN0ytAwi54FPEtyd86DMOL9Wk8urSBoFQElNOjQDtvOl0ArZApuCpKu08U4nvlkviN6b+3ZphpomdaIwAwYSlx7sDLvepDPhIGUeLV59Vgk9/aIPtDLRvNNViqQd9bpCTdvHO6yCE5Bu4CWTov+O1/nPahxqujvPaaRsb/UzgXaGbLiPNjvWtrhsXGI0mwrVT80KBS9itToRD2W3fR56o+XobtfCiCSYC/QDtNVNVx4PzF2cB/DMkhqcoUuhLkoQ80GaZY2nEK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/H2H0L+opiMM37vu+W7lTjPIbZHyyxil5b1uIRjgcM=;
 b=dFIrWl5ReVHi3zs5F3yv4bkmNf4e4VxWGrKIrLlqZ4/r2wGb3VuQVMjtwLd457bkys5XipF6HnmSJTpoVeqB89BuGULVOChhDBjoj/eyo40LwcHG96ZBW5yqCEFKrIFuCgcclrcxvoGjhLVUs0hJS8yHgE8b3ZTj8VGDH69Ncff5u+AuaZ5+O5JfyxFolKv1eCyMJFrZreMolVDN+BLo7tAmgSvseuE0DGpmb0w5w5Po6VEKwHVVvystNUGF5wprQQvF+4SZu51fbC+/8C4hClWQjX5mb08kX9qETjf15t6Qqhm2VXK3DlkRyLr5gK1N3id1zlWi6HbJyOLOt385/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/H2H0L+opiMM37vu+W7lTjPIbZHyyxil5b1uIRjgcM=;
 b=iHX1S7dnd3LWEJowrqxkz53Mzal6u4vHuiBov330H5VAQSUIPTbfAsMPNk0+g08qvmah1d8xF5EMJcFYcw6hyGr0tYvpUrN+rj+pe+TQhDYJQrwig3huDQ53b1z55JiEsWRP1wHfoPtFmUVWekQsW9rkmsePkIJKXeZEElh2O/0=
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB2362.namprd13.prod.outlook.com (2603:10b6:5:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.8; Wed, 23 Sep
 2020 17:33:35 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3433.013; Wed, 23 Sep 2020
 17:33:35 +0000
From:   Sagar Kadam <sagar.kadam@openfive.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Yash Shah <yash.shah@openfive.com>
Subject: RE: [PATCH v1 2/3] dt-bindings: riscv: convert plic bindings to
 json-schema
Thread-Topic: [PATCH v1 2/3] dt-bindings: riscv: convert plic bindings to
 json-schema
Thread-Index: AQHWh19i+MNhYtLbO0WaWaqZxwh8y6l1MMuAgAElMQA=
Date:   Wed, 23 Sep 2020 17:33:35 +0000
Message-ID: <DM6PR13MB34519BC4A72557B58445FDF697380@DM6PR13MB3451.namprd13.prod.outlook.com>
References: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
 <1599734644-4791-3-git-send-email-sagar.kadam@sifive.com>
 <20200922203429.GA3188204@bogus>
In-Reply-To: <20200922203429.GA3188204@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [116.74.150.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba9eb04b-18c0-4654-26f6-08d85fe6ccfe
x-ms-traffictypediagnostic: DM6PR13MB2362:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR13MB2362C7360313494252C15EA797380@DM6PR13MB2362.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ijp7K2LJg3ThgJ5nGgjea3ayuaRBkSRGF8ndc0flantKclD3WS58JZ60CVxmrEJgSz33Zxo38P2OiJRCoGfIFTRNurNEJpOBIMH6rSIMdqlZlH22NLQUOgAHiROSTSXu29cQzKB66FREuvVCh/c0O2ZxWwRFZ1FeuTa5QSOnsJFJPl1WS3HRsKhokUfzVb+P7qpj9EYy141mQuEe85iI//IcNmM0X/JLro5FSQKzYuxoGGNRbOiLYYdwt0flyd+SoAFZKXF/wpIXF9RUgQb+PYiqQsewdTg29EnbWa0smwbIgi/0PJtEKU5keYcK5gGFHPQC2QigMI2/D7DHz2BNY+bOQZQ7S++QimYgkP646RBT8vq3InQx96AyB6tRrpLsxc6riBVufo2l5eI2BOzSWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(39850400004)(136003)(5660300002)(8676002)(966005)(6916009)(107886003)(86362001)(4326008)(9686003)(8936002)(55016002)(7416002)(64756008)(76116006)(33656002)(52536014)(66946007)(66556008)(66446008)(66476007)(71200400001)(83380400001)(316002)(54906003)(44832011)(55236004)(53546011)(6506007)(186003)(7696005)(2906002)(26005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zVa4RRNsGG2Rnep8G4ePhc5cPfoQb2ky96ezL2r5Rg7T1GGH3K0BIvpjVw4Ny4tTNrs7PPoT4zJY9/zgrXjccHZ1pS25Vlmn8ffX5Uvcao+D8/MZVRQr8NRDUw0AwWqN3L67mpT5mQzv8D8+ECbIpzNgwgx7Iij8zfX/bkkZ7U6GCSrg1LVPqPKwJzLk8Lo5yXaObKflrMjY7yHI/+sqbIHTkGE0ALL9NwejLiptV3AlcgDxCdBhv0SsN4sHxyqCY5sdk2h3XThJ7VPqBc1su1Itkcf2DRp2c+XtPe/qNjf4wCQDBaBN3SLv1WV/oYuJGYhW4G/puKVP0PYwbVsjxTE5GGvkI+06pwvf8oBQskM5y6ROMAd63D84m4jp7JHak9OypFxVnAZ8DOaOrU9eCVe+sFC7jJXa1+zdE2p2rlqNEtZMaixKW2Ha9f3dHZUIhwh177n+zr2xfPGFvRwit+HV7B4ubteN1VxCO/6Bsvm646XsxMvKiigcTKgqdAyNk6HEdPHSqPs4dNDsU+5cHLzYwag1HR3HNcUWOi81xuVIRVbwE8JNhp1PBaN5aQF6NeuY4Ova4O4xNuPujFnsvxlPYwdT8Er9f0Yz2kbI8/l8OH+OsmDMITx0Qis9AVIz6P9BFxp7PYyjQ/dTXSLuHg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9eb04b-18c0-4654-26f6-08d85fe6ccfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 17:33:35.8640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwngPV8XtiqI06j8AFlav0eO/4yOjk0moSkOQZX6Kx5/6PEC/udhpjXtoqytq6Rt59zsh3x5Wk8cSZeEyskWAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2362
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, September 23, 2020 2:04 AM
> To: Sagar Kadam <sagar.kadam@openfive.com>
> Cc: linux-pwm@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> riscv@lists.infradead.org; devicetree@vger.kernel.org; linux-
> clk@vger.kernel.org; mturquette@baylibre.com; sboyd@kernel.org; Paul
> Walmsley ( Sifive) <paul.walmsley@sifive.com>; palmer@dabbelt.com;
> tglx@linutronix.de; jason@lakedaemon.net; maz@kernel.org;
> thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de;
> lee.jones@linaro.org; aou@eecs.berkeley.edu; Yash Shah
> <yash.shah@openfive.com>
> Subject: Re: [PATCH v1 2/3] dt-bindings: riscv: convert plic bindings to =
json-
> schema
>=20
> [External Email] Do not click links or attachments unless you recognize t=
he
> sender and know the content is safe
>=20
> On Thu, Sep 10, 2020 at 04:14:03PM +0530, Sagar Kadam wrote:
> > Convert device tree bindings for SiFive's PLIC to YAML format
> >
> > Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> > ---
> >  .../interrupt-controller/sifive,plic-1.0.0.txt     |  58 -----------
> >  .../interrupt-controller/sifive,plic-1.0.0.yaml    | 107
> +++++++++++++++++++++
> >  2 files changed, 107 insertions(+), 58 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/interrupt-
> controller/sifive,plic-1.0.0.txt
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-
> controller/sifive,plic-1.0.0.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-
> controller/sifive,plic-1.0.0.txt
> b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-
> 1.0.0.txt
> > deleted file mode 100644
> > index 6adf7a6..0000000
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,pli=
c-
> 1.0.0.txt
> > +++ /dev/null
> > @@ -1,58 +0,0 @@
> > -SiFive Platform-Level Interrupt Controller (PLIC)
> > --------------------------------------------------
> > -
> > -SiFive SOCs include an implementation of the Platform-Level Interrupt
> Controller
> > -(PLIC) high-level specification in the RISC-V Privileged Architecture
> > -specification.  The PLIC connects all external interrupts in the syste=
m to all
> > -hart contexts in the system, via the external interrupt source in each=
 hart.
> > -
> > -A hart context is a privilege mode in a hardware execution thread.  Fo=
r
> example,
> > -in an 4 core system with 2-way SMT, you have 8 harts and probably at
> least two
> > -privilege modes per hart; machine mode and supervisor mode.
> > -
> > -Each interrupt can be enabled on per-context basis.  Any context can c=
laim
> > -a pending enabled interrupt and then release it once it has been handl=
ed.
> > -
> > -Each interrupt has a configurable priority.  Higher priority interrupt=
s are
> > -serviced first.  Each context can specify a priority threshold. Interr=
upts
> > -with priority below this threshold will not cause the PLIC to raise it=
s
> > -interrupt line leading to the context.
> > -
> > -While the PLIC supports both edge-triggered and level-triggered interr=
upts,
> > -interrupt handlers are oblivious to this distinction and therefore it =
is not
> > -specified in the PLIC device-tree binding.
> > -
> > -While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> > -"sifive,plic-1.0.0" device is a concrete implementation of the PLIC th=
at
> > -contains a specific memory layout, which is documented in chapter 8 of
> the
> > -SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC=
-
> RVCoreIP.pdf>.
> > -
> > -Required properties:
> > -- compatible : "sifive,plic-1.0.0" and a string identifying the actual
> > -  detailed implementation in case that specific bugs need to be worked
> around.
> > -- #address-cells : should be <0> or more.
> > -- #interrupt-cells : should be <1> or more.
> > -- interrupt-controller : Identifies the node as an interrupt controlle=
r.
> > -- reg : Should contain 1 register range (address and length).
> > -- interrupts-extended : Specifies which contexts are connected to the =
PLIC,
> > -  with "-1" specifying that a context is not present.  Each node point=
ed
> > -  to should be a riscv,cpu-intc node, which has a riscv node as parent=
.
> > -- riscv,ndev: Specifies how many external interrupts are supported by
> > -  this controller.
> > -
> > -Example:
> > -
> > -     plic: interrupt-controller@c000000 {
> > -             #address-cells =3D <0>;
> > -             #interrupt-cells =3D <1>;
> > -             compatible =3D "sifive,plic-1.0.0", "sifive,fu540-c000-pl=
ic";
> > -             interrupt-controller;
> > -             interrupts-extended =3D <
> > -                     &cpu0-intc 11
> > -                     &cpu1-intc 11 &cpu1-intc 9
> > -                     &cpu2-intc 11 &cpu2-intc 9
> > -                     &cpu3-intc 11 &cpu3-intc 9
> > -                     &cpu4-intc 11 &cpu4-intc 9>;
> > -             reg =3D <0xc000000 0x4000000>;
> > -             riscv,ndev =3D <10>;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/interrupt-
> controller/sifive,plic-1.0.0.yaml
> b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-
> 1.0.0.yaml
> > new file mode 100644
> > index 0000000..95c8c85
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,pli=
c-
> 1.0.0.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +# Copyright (C) 2020 SiFive, Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/sifive,plic-
> 1.0.0.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiFive Platform-Level Interrupt Controller (PLIC)
> > +
> > +description:
> > +  SiFive SOCs include an implementation of the Platform-Level Interrup=
t
> Controller
> > +  (PLIC) high-level specification in the RISC-V Privileged Architectur=
e
> > +  specification. The PLIC connects all external interrupts in the syst=
em to all
> > +  hart contexts in the system, via the external interrupt source in ea=
ch
> hart.
> > +
> > +  A hart context is a privilege mode in a hardware execution thread. F=
or
> example,
> > +  in an 4 core system with 2-way SMT, you have 8 harts and probably at
> least two
> > +  privilege modes per hart; machine mode and supervisor mode.
> > +
> > +  Each interrupt can be enabled on per-context basis. Any context can
> claim
> > +  a pending enabled interrupt and then release it once it has been
> handled.
> > +
> > +  Each interrupt has a configurable priority. Higher priority interrup=
ts are
> > +  serviced first.  Each context can specify a priority threshold. Inte=
rrupts
> > +  with priority below this threshold will not cause the PLIC to raise =
its
> > +  interrupt line leading to the context.
> > +
> > +  While the PLIC supports both edge-triggered and level-triggered
> interrupts,
> > +  interrupt handlers are oblivious to this distinction and therefore i=
t is not
> > +  specified in the PLIC device-tree binding.
> > +
> > +  While the RISC-V ISA doesn't specify a memory layout for the PLIC, t=
he
> > +  "sifive,plic-1.0.0" device is a concrete implementation of the PLIC =
that
> > +  contains a specific memory layout, which is documented in chapter 8 =
of
> the
> > +  SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-=
MC-
> RVCoreIP.pdf>.
> > +
> > +maintainers:
> > +  - Sagar Kadam <sagar.kadam@sifive.com>
> > +  - Paul Walmsley  <paul.walmsley@sifive.com>
> > +  - Palmer Dabbelt <palmer@dabbelt.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
>=20
> Don't need this. It gets selected matching on node name.
>=20
Thanks for your suggestions. I will incorporate your suggestions and send t=
he v2.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sifive,plic-1.0.0
> > +      - const: sifive,fu540-c000-plic
>=20
> Somehow these ended up in the wrong order. Should be most specific to
> least specific.
>=20
Yes, will rectify this.
> > +
> > +    description:
> > +      Should be "sifive,plic-1.0.0" and a string identifying the actua=
l
> > +      detailed implementation in case that specific bugs need to be wo=
rked
> around.
>=20
> Drop this.
>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description:  Should contain 1 register range (address and length)=
.
>=20
> Drop this. The schema says this...
>=20
> > +
> > +  '#address-cells':
> > +    const: 0
> > +    description: Should be <0> or more.
>=20
> Drop. 'or more' is wrong. If there's a case with more, it will need to
> be documented.
>=20
> > +
> > +  '#interrupt-cells':
> > +    const: 1
> > +    description: Should be <1> or more.
>=20
> Same here.
>=20
Okay.=20
Will remove as suggested above

Thanks & BR,
Sagar

> > +
> > +  interrupt-controller: true
> > +
> > +  interrupts-extended:
> > +    minItems: 1
> > +    description:
> > +      Specifies which contexts are connected to the PLIC, with "-1" sp=
ecifying
> > +      that a context is not present. Each node pointed to should be a
> > +      riscv,cpu-intc node, which has a riscv node as parent.
> > +
> > +  riscv,ndev:
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    description:
> > +      Specifies how many external interrupts are supported by this
> controller.
> > +
> > +required:
> > +  - compatible
> > +  - '#address-cells'
> > +  - '#interrupt-cells'
> > +  - interrupt-controller
> > +  - reg
> > +  - interrupts-extended
> > +  - riscv,ndev
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    plic: interrupt-controller@c000000 {
> > +      #address-cells =3D <0>;
> > +      #interrupt-cells =3D <1>;
> > +      compatible =3D "sifive,plic-1.0.0", "sifive,fu540-c000-plic";
> > +      interrupt-controller;
> > +      interrupts-extended =3D <
> > +        &cpu0_intc 11
> > +        &cpu1_intc 11 &cpu1_intc 9
> > +        &cpu2_intc 11 &cpu2_intc 9
> > +        &cpu3_intc 11 &cpu3_intc 9
> > +        &cpu4_intc 11 &cpu4_intc 9>;
> > +      reg =3D <0xc000000 0x4000000>;
> > +      riscv,ndev =3D <10>;
> > +    };
> > --
> > 2.7.4
> >
