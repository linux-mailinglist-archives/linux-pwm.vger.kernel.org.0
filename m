Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0526D629218
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 08:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiKOHCn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 02:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiKOHCl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 02:02:41 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E887A1FCD5;
        Mon, 14 Nov 2022 23:02:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnwDr8zzTB5x8SHdqDsgs3dzE0NW7BC58SkHI8f6B5zF4B8HlJmlNdK7dnm1mYRaZX4/bKDox8aUtEkkRo6KnR0+WrINctWybYgXoe23CVCmXILLNUXQy+vumSQbf8qDTt8Q1g5GhQKVd3Vvnkh0lrE9Wq4IUhoZvUggYOHm21ahMig65gpfsvNBQc/8tBU7gqeOWgHiMQo6vCT5Wb6b1ZaqVIpf9kD0Hr2JzFe7xARo+6Kx65e+bsDDkdW0aYPyw18TVMWVu/cV4hJbz4k7G9Zz81p99U6tU5uvUVPE04L4dynfxn061TrCqPDZQv7g0Wiq+hRkXGIFLMon7gdvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gjfS4TiYYdozY+yQ2A/btHVEjGDeXdExYG5tocnzoM=;
 b=D31jnaOT1MEbxTSfPiOGeUYjqZeV7XqkyRQSGWpqYo1bXvcmJzgG3OydXSzGVzt+DojTO6/NLxi/QpOkiBnZXGsfccQjLoEwZlEaNu4Peo/kktl5qsh9mafUOTwucKKvpSanxnKtCdIBMF+IhYlBsDGcJFOVlINS/J7+UcGydwCudzhAFB7HT2UEfdhGccAFNUKiON3q8q+x8BIyzhWsUBEXu4uoRex9lNP6Hy0sh47+HRVGBs4oWtS7JbvKkyVtHI+WroG8//kBs/XN5gkYB8r+svQlIfRXr9NxxfigtMujH7fSCXJW4p+i2qSt/q2NsT59qs+fArlIZTJHT/ntFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gjfS4TiYYdozY+yQ2A/btHVEjGDeXdExYG5tocnzoM=;
 b=uE6T2aV+1PGJ3M001/wBWLPzCktdrLAzUROvupN8yxwTrpvL0vs3YiEIizYNBec+b6LyfqQmaOyf36aOb/YJDjxzF7mx441BLWgArlcxQPP4FJLFQc82jeybKbNe6WzbxefatEaFSQYpyr9XTUv3R++hl9afBc7nFHZqHrruhS0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6064.jpnprd01.prod.outlook.com (2603:1096:400:4d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 07:02:37 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 07:02:36 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Thread-Topic: [PATCH v2 2/3] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Thread-Index: AQHY9gP9Y6ABJ6CNo0KfXhDTinrESa4/PA2AgABTcxA=
Date:   Tue, 15 Nov 2022 07:02:36 +0000
Message-ID: <OS0PR01MB5922756F1836AAABFF62C04786049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221111192942.717137-1-biju.das.jz@bp.renesas.com>
 <20221111192942.717137-3-biju.das.jz@bp.renesas.com>
 <20221115014613.GA3959192-robh@kernel.org>
In-Reply-To: <20221115014613.GA3959192-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6064:EE_
x-ms-office365-filtering-correlation-id: e1259bbe-ae57-4a61-5096-08dac6d760af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JyDjivDBPMnCReZCCVDuIeZvP+nblASvi/oxj//N8NIlJdGMlNAG9gZuq0qN3K/Sveo5h4ishVdQcC8gsBwx2amPT4Qg3zmqUjDEPUad9r9fEyjIAO4MOsCyKJCqDqSVJMzQK7Q3mUW3jAfQ+svjpjytY8J0DM97N9a2wvXChDlVBHTaT0oeotfZvwDJ1vJCOOA+VT/MNKLews/g2BQvqgRXe2EH4QQL814QbZg1XtTqzXZQFzgs3AACS9k1DOlb1+SpK9ICbTnmoeRWcG59OS74g1vqzM5VnmqutedEFdOgKM10hRuNnHz4FLtXP/X58/uGYcSvMyLvX1eTY50OJe425LIZrKxx37VFVlIaaYzI7h3Q6bSuuFt5fmRkvQYS/v+YwUIBj+dbo5ekqJXohlRncdoNayEvA4a6acpuKCKaxlo7n3heV8Zw/2EIEVb2ZyU8l98gA+SMqB15HlYvM6JTiwQVP7jotpsGExmjeFe/ntwL5LaczeabKnI/0FQ19L8tWPIi7QhqWJo+eU4Mh2Ohqrj6kGp5rU0dFM9ic2C8XeU5U35+hRDSMRDQnPSvRxkHdb2UWaIC5Ycj/qp7nYSAXSrIapK7xtGeeSIfQRv1fTPHE6LgCyWoKNJkwkJhC3iyCTMK1V/MOYGdZiPJW+imAfRF6dhiQu0C6V1u5iw3yZuB9I2xg7KBV8VTzRmUviLW5WUIX0KRl59kVe2ZqYcgWy0BK8nzAGOEPNnH1OWS0RzyEvd0u7hRxZnhRwro0YRiWAjycL4VvoEj5rKU0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(478600001)(71200400001)(6916009)(54906003)(55016003)(8936002)(6506007)(52536014)(41300700001)(66476007)(2906002)(66446008)(53546011)(4326008)(26005)(66946007)(316002)(66556008)(8676002)(76116006)(9686003)(7696005)(64756008)(83380400001)(186003)(33656002)(86362001)(5660300002)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mhHYd6fAgGkBRUzGimXHJoUNlx+oQSJ4mAF/lwZj+1o1U7s0t6zWlwaege?=
 =?iso-8859-1?Q?F05d77mxIPndOq8IlVFco3YVDuLryWoaUsSAhZEBeXWe5jCB9DcTeC1gtx?=
 =?iso-8859-1?Q?HiAJwVyff5ndZXECxD/zyDLn9pipBOM/5mdbWYrppxK8vrwjvnX40ereYL?=
 =?iso-8859-1?Q?2UwbQ9vXo9UVspvzLaKXa+V2e4DvDR34G8I5l1b/p2W4vR6U0LUkJ3Nzv+?=
 =?iso-8859-1?Q?qjBk4zeIjKRC1xsamgz1z0l1P1SjN+7d+9V/BnjZsjGNoQd52g9agjYQle?=
 =?iso-8859-1?Q?smz65s9BBUj78u+D0KjV9yFJuh61SWv22Ady+Cz093sYUuPmcfPM0nsWwe?=
 =?iso-8859-1?Q?3pCrR+UHHMOjZnY4AGfZI+ypXhfnorg9iWJrbeZDw0zWd8NOvP74nGRA1D?=
 =?iso-8859-1?Q?KwX1qmmMTRo6AooY8bc+RLjIlQxEAqOguBIs9ivtfddu/tezf1OpMF7Qce?=
 =?iso-8859-1?Q?PBxLQZEhcXracoon7dOJPIY7MJJ1/WP9aBKM/MRS9y07/jC2opJ7DswmW7?=
 =?iso-8859-1?Q?TQ5yb5Jxvhy2rJTaayNPsptiNMmtfumrC93Ng5D7dOmc6g0pTFi3NaskJz?=
 =?iso-8859-1?Q?H3XI73BIatbze9aVEQZfdJz/MpWLwhCE4hG3v7ejEoG0/CLJbsQKc1R/nD?=
 =?iso-8859-1?Q?lph47tfcSX0mCZwgYbf5govehA/8K9MTuj9IkeoqwHGpjAu+yei+jkj/ux?=
 =?iso-8859-1?Q?PUJY3MzHT2hISRl2AMv5YLbOsyLphez8j2rDbN66hhyT69bArDRw+e4e1F?=
 =?iso-8859-1?Q?Tnx+Wd0zxhYjHd8O22pcPaW6e4MvJY3pdKiDEryuWKogEQINqv4o5cJD/V?=
 =?iso-8859-1?Q?GPnMJMQ8pzKyo6y/98PhVvYew0Ds0C0V2+Jcv57i+YaHidRJ8VV90zRBke?=
 =?iso-8859-1?Q?abByIYZlt2Vb3DrNeRSM4fBqotz9wriZDXqetYuTEKolP3m4GDp5dBYXjO?=
 =?iso-8859-1?Q?TDtlvODxyfGumHl04qDcNkhnFZMDHzhAlTeG4LULxcFmkWJjX5pKCSueAN?=
 =?iso-8859-1?Q?/hlA5aS52bQaSHqmiQE/s1DIPAxgttIEdWaiNCLYbH0rQE0zJ6A6EAHduE?=
 =?iso-8859-1?Q?0AgK8KH9VCYejT2c/5RBwo+4ZghIoQ63Q62gsIPZmGQgagGlm5CZcdX15x?=
 =?iso-8859-1?Q?2KbWuyJmVftqjbHH1b2sT8sDfjQo/gf6os/ffxlVxQh2v2pDn+oSn1YYzN?=
 =?iso-8859-1?Q?BKUJWzKiAJK/JlgAQJEVdujYr1gNlHWfo45uw3COvRjpDdQNs1Nmt/E8zw?=
 =?iso-8859-1?Q?IfgsQuiZzkV8jz23saCVGroyFpNgl7aurkqh4tjDXkXtQb/RmI7IupIdZX?=
 =?iso-8859-1?Q?6Yi78QBpSYVz4kqQE/WV59oaNGPCO7v2p/vbP1mxKa0kTjGu1NSuJrY7dN?=
 =?iso-8859-1?Q?KLaD6aY1UFAGzkpCsPYQ12ZDRmSA0/bYN1E1I/q5tsIgWbvKJMVFDK970K?=
 =?iso-8859-1?Q?85H35lZ4D1JKzIZH3dmE1e0eUORs7jqDazP5n0Et2JLUYZtpPDYunu3NIM?=
 =?iso-8859-1?Q?sVBdIGLPj1xQh6oc7UvushLhlf4K8cq3t6H/uSjoPrUOz+3T5KVAw9N/as?=
 =?iso-8859-1?Q?jIe0Mter16kh6CwEyLoo6Nc3wDMF8qYE0RHKANjE27m3sOdAzApXIgVLIx?=
 =?iso-8859-1?Q?NqPAOHijCZIQKWw6np2c6EzfpgRiDwpKzB/W78SnypOTFp2O6iZnRQqg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1259bbe-ae57-4a61-5096-08dac6d760af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 07:02:36.8248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKxvNlQz3jX8/yN9BIHJH3gqwJJYmeRLR5JRG9pUSukW6wE6+efgu9OG2hD44oQ5K1HVDaXgBEKjEBhN+j2cQa9ZFsxVV9+oto6fHqxBJ1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 15 November 2022 01:46
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; linux-pwm@vger.kernel.org;
> devicetree@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-renesas-
> soc@vger.kernel.org
> Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: rzg2l-gpt: Document
> renesas,poegs property
>=20
> On Fri, Nov 11, 2022 at 07:29:41PM +0000, Biju Das wrote:
> > RZ/G2L GPT IP supports output pin disable function by dead time
> error
> > and detecting short-circuits between output pins.
> >
> > Add documentation for the optional property renesas,poegs to link a
> > pair of GPT IOs with POEG.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * removed quotes from ref
> >  * Added maxItems and minItems for renesas,poegs property
> >  * Added enums for gpt index
> > ---
> >  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 23
> +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > index 620d5ae4ae30..5219032c60ee 100644
> > --- a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > @@ -245,6 +245,28 @@ properties:
> >    resets:
> >      maxItems: 1
> >
> > +  renesas,poegs:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      maxItems: 8
> > +      minItems: 1
>=20
> I think you want these moved up a level with the 1st 'items'. It's 1-8
> tuples, right?

Yes, I want something like below, so that a gpt channel can be linked to a =
poeggroup.

renesas,poegs =3D <&poegga 0>, <&poeggb 1>, <&poegga 2>, <&poeggd 4>, <&poe=
ggb 5>;

Thanks, I moved this up a level and the checks are now passing.

  renesas,poegs:
+    maxItems: 8
+    minItems: 1
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-      maxItems: 8
-      minItems: 1

Cheers,
Biju


>=20
> > +      items:
> > +        - description: phandle to POEG instance that serves the
> output disable
> > +        - enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> > +          description: |
> > +            An index identifying pair of GPT channels.
> > +              <0> : GPT channels 0 and 1
> > +              <1> : GPT channels 2 and 3
> > +              <2> : GPT channels 4 and 5
> > +              <3> : GPT channels 6 and 7
> > +              <4> : GPT channels 8 and 9
> > +              <5> : GPT channels 10 and 11
> > +              <6> : GPT channels 12 and 13
> > +              <7> : GPT channels 14 and 15
> > +    description:
> > +      A list of phandle and channel index pair tuples to the POEGs
> that handle the
> > +      output disable for the GPT channels.
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -375,4 +397,5 @@ examples:
> >          power-domains =3D <&cpg>;
> >          resets =3D <&cpg R9A07G044_GPT_RST_C>;
> >          #pwm-cells =3D <2>;
> > +        renesas,poegs =3D <&poeggd 4>;
> >      };
> > --
> > 2.25.1
> >
> >
