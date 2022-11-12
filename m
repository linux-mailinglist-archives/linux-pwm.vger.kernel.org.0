Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418E0626889
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Nov 2022 10:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiKLJdW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 12 Nov 2022 04:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiKLJdT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 12 Nov 2022 04:33:19 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2128.outbound.protection.outlook.com [40.107.114.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329C5F14;
        Sat, 12 Nov 2022 01:33:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6Y4DDx/WQr0skrCJ1yRtXxU7y0i6YUdtNK/yTRO/OTPbJDhncmrzVjmMkAl18Tuvuk10kcbWqu14sRmeRLrJoc9zzZqvqP/eyOTApZi5BsI+G9G5HCvVEzQsD5e7UC00ABenQT3RQTfSPoO0CQADj8zWsaGAHzdRlO7UJlnuUNGtlJqmuWH7Dlull4JuH88hfqHYngRJiIpoo6J7JwDYd5L5amzKww+dtJxxEGK7NdgYRXLAz9v13BWzOYY5KZwnjIG4e7t5WGbaWq9FzyLJOqhquZVp9YN9p3kshDYP8lh3DIgVUXp8YMsvuEwdUUrdkDLyVR5AJU5oODFuVkLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFpndfVyDBYHOE06Q3gTWB8qpEeZVAEFwsIiL0LjEUk=;
 b=R3D5pKxW3jUFtnQNM4Bw6GmD5LO5PE6/F3GIQcZ2Cr+cKR+Hs0qVAWhe1Ly7qu6af0zMOlhpP7VW56l3322cH7f+tvLk7SKnQI+s4XerhLEP0f8BaY3RaYql20D201nrJ2JZFeiFpnC8frxH4vU5zL6hr3GXiLaWWOAlXLilerLyPDm9flOsrTZNxfcILCUQg+Wa3Plg7aQKTrB9u09iw90vIw8v1qEt2jxHfT7fm8JRMOh7YkWkbIKuuGakx2lzYZ9XJLcP0P5irKILxBay9uu7wFvrPG4QHQ7SRU2HmC9VRWAlysz2DnNYtL4SRn0IN8EVAPk1JeCSKv+4w0q0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFpndfVyDBYHOE06Q3gTWB8qpEeZVAEFwsIiL0LjEUk=;
 b=HT3XoXI0t5PRlAMJPf783BJJ4jgBbNcMxgjNpbidykPiSRbefBaFklcEomK/GNK4kb5yWLySfENDJEFqI9WwscAHm9JYYtEb/apIzgnWOhRVBicS2EVsB1WTcSdLwwZZWnj8kk98n7w5S8P3LQ5mXXNhsVQcdwfmAuwafL09BxA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB9331.jpnprd01.prod.outlook.com (2603:1096:604:1d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Sat, 12 Nov
 2022 09:33:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.016; Sat, 12 Nov 2022
 09:33:14 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: RE: [PATCH v2 2/3] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Thread-Topic: [PATCH v2 2/3] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Thread-Index: AQHY9gP9Y6ABJ6CNo0KfXhDTinrESa46ajWAgACb6EA=
Date:   Sat, 12 Nov 2022 09:33:14 +0000
Message-ID: <OS0PR01MB59229314C88BF8B6734076F386039@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221111192942.717137-1-biju.das.jz@bp.renesas.com>
 <20221111192942.717137-3-biju.das.jz@bp.renesas.com>
 <166821148218.241040.12720094893409312973.robh@kernel.org>
In-Reply-To: <166821148218.241040.12720094893409312973.robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB9331:EE_
x-ms-office365-filtering-correlation-id: 3a0e0375-4195-4f6d-8c38-08dac490ec3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p8TG22VsxThh0j4NIbkZSXZN1LHZ5eidnDpJPKrE2SiEAeTNmeJaxPjGhnIEoUXh9p+0rNVz8YLvbdH2UnPHn5ZaQwEOjm5VRCjwgBw7GH+Xm0XEW+7OmodwS7RNNOmFaGS9LDEWmIw2kl88evqtiTPlfH906S/6dkE4s/9YMIZx3S13ymOk913uj53+qLKNDCHoTY1NWhwaQ03M55pzWFwK16zBq5z9lJIQVF0tKSVn294gictVcJMsrdCW+KnfeKLot4vkVMK2k3uinvWnJ/wRVqXodDqY680M1iDgqBwkp7rDt/KVRwfRgsQJgqcg054gMRfyVGxdpT1NMeMm7QrHhlZXFaXWh6aMeHXc5TySt6jk8wUjDzoRp+Qjd3TH8HGabpCgU881sy6dGY/suPJKdHfe4omZQEbWupjXfQWvOUV9QLo9+j8vwQVqwN3QEquOYdvDzcnc90bKjElm6ucOkys6hGM07KoPl5jmF7t3pYcUS8WCEI8WeLlfM8kan5zP6nQbkfEAWDfN46nB2b1332DguYS5eVomU/vKclyiPz1pvMESMAFXTG5PULIlK6kTNj9IlWv20pn7s/S/ohMAdHIeoiHPiRLiC97L54rgFaNAQTy/48vVOP5rLQLMjlTtsJJ0+KM1ZhT4S9J3x+cN0w+XVKSd8tWxGRlpM4ZbQu0R7XjWS+dkOA5p2BDLDD1+XX1faNkFI0724cpADV/+iVhBOTa04T6jIkO+HZfX9iOnPXcU6born0LriQ0ETxnvybzOW4wM0mSiIbarw57piMZk29CcmN7Yft3jJ2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(33656002)(316002)(2906002)(54906003)(110136005)(86362001)(55016003)(38070700005)(4326008)(52536014)(5660300002)(122000001)(8936002)(38100700002)(66946007)(64756008)(8676002)(66446008)(66556008)(186003)(76116006)(966005)(9686003)(66476007)(26005)(478600001)(83380400001)(41300700001)(7696005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ON3YVLCVG3wf6pjNsqhfdESx0nZQgIAMOQm4hKm280xuCibJ+L5OY5g7UY?=
 =?iso-8859-1?Q?fS/o3i1g+wiI52eoQ+IG0C1OKJesgX/rRhhFHtwgAszEHzQlBmLegw9LeA?=
 =?iso-8859-1?Q?SNO9vpyeVDF1InKimyhpFqn+dmLtWQNZsK77V3Kwlin8dL57JrYaDeOHvt?=
 =?iso-8859-1?Q?YF5nMuEFTMFcaNh8+YtF8GYvAUWoK7t1psAPOR5ZFkMJ43ujqBNzj2rvDh?=
 =?iso-8859-1?Q?9JclmpSr7HC2CQrszYa7cT4wGBa5TNFFM2veH/MpUH51SsG20UwdyIOrms?=
 =?iso-8859-1?Q?9sfqKpTS1KB9B3HCgRfAaRwKjRVL6Qk9aSZ4uUmfQbCXpkLXhWSj0iIIYM?=
 =?iso-8859-1?Q?8kZPALi9qU5GL+aAWDvb0biGaEeO4Cv6sdSOI84EzeLp5hjY8AqFziqvgf?=
 =?iso-8859-1?Q?rHLqbF9NTya+3oo6bY8n4uJA7J4cQ3tw3gIqxhGmQwd3DjY5cZwEoi+Jcy?=
 =?iso-8859-1?Q?hIGU1c1AvKbZ7hCG4YLG316E8vCGLdtzTTCm6YEl4CuM3rqX7e9O4b8CeE?=
 =?iso-8859-1?Q?e+dTcTlGmRL4v1hHFFWZe9frgFvbXACevq1JHdpxD+MHpCQsafZbjIoLaD?=
 =?iso-8859-1?Q?kkcfcECJxYwW6C5H8nXd5jjJYW1aL91fn2MNRG1DkaLAS6xoZb20KBWBf5?=
 =?iso-8859-1?Q?LY7pl+9dAGN2HVf5Rd9HBDvu/KYv1SgnS7+wm8MbYBo0lHK2KrErAsfZ2e?=
 =?iso-8859-1?Q?yJaDV1WtCwN6/0LSlIiIO6awCR2o8T/VV7UA3CHpS78PGuIbu9B8SITjby?=
 =?iso-8859-1?Q?LBPeSUOBnzVUDHFIgEuGLK/Aj+3t/+kSsbL45qrEl2gF23zwOPrVPLAYeM?=
 =?iso-8859-1?Q?ZHrljfB+Jid+zA6gENAEZ1OOoFum/Ravch8OYSB+ZLvmmitsjXU3SNLCOM?=
 =?iso-8859-1?Q?qCvruu9yi0ZFCDqUwKtAY40lwXbhJiRaxiY49ITHKMfDFddDd8m5hZk0xy?=
 =?iso-8859-1?Q?7zSApsSfesoW3QeF7ClIHDyAlG2+qpwRBVY1QZmHodO3GHXZVTBRtaIj6H?=
 =?iso-8859-1?Q?yuC+8kQnE+xsv0P07ppqALOXQ54vBkd7Gvhx+0GB+GfIWk8ebu0db9l1+C?=
 =?iso-8859-1?Q?t8XPMDwcF1LfLg9Q/IDjLyAfq3NOdPrBfXfx9Nlfhu0gqV1F8SM52ZAnR+?=
 =?iso-8859-1?Q?iF5z2Mhwxe8QmGM7Yh26IyvD2gsTh2e3w1BkpX20lQVsDeIoQhOyOmV28q?=
 =?iso-8859-1?Q?VGEJmWIrgKt36hCVo7DivgsSOk0J05i0oGv/N1IK3pi5naLnCeuOUQXn8t?=
 =?iso-8859-1?Q?hk+d3z7AGgrA8p6oWwjecmNfA4IYzXI2OeXIY5LPSdgqGs5aVHwKHwJNt7?=
 =?iso-8859-1?Q?ont41pukezia+8A/ilDWX69RzLF6cglN6waR7XHyzhJWXPKGQNK41kWAvK?=
 =?iso-8859-1?Q?yDwdASq7ANjU7Iy3LTkcU6w68cIEGfY5TJi+BjwzDRePVobLfE26SFE+Vy?=
 =?iso-8859-1?Q?h7OccHSjNp3H5w+s49YmslOkd2r1iTCZGnN4FRqCDD9fLImRYImyYvM8Rk?=
 =?iso-8859-1?Q?Zc/s4bxeWCVm5Gm81oT7Gwd46C+ugLHsmvqGQ1nhXfb7u6WflKf2EFPwWq?=
 =?iso-8859-1?Q?yASLG9kTfpx69sDxPHHFdn1tOV/VyI8pfaAQVyEtgJ7ecpPG9rTz8qqeX/?=
 =?iso-8859-1?Q?F/e9LJQ1KVYpOBVJdkbyYFaSkqEod+JkZTlZAkCmUd7tXPHFoTAlUAeA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0e0375-4195-4f6d-8c38-08dac490ec3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 09:33:14.3915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6P9748Vz0WbvKbI9Cac6qKyURVPdLdDXeSgIjKqLkARqi65YVZ5jIoRtcAS22X93veP4f2/kxzDkU2gZRC46fQPFVVlFUuO7EA/3ld4g0GU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9331
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob and Krzysztof Kozlowski,

> Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: rzg2l-gpt: Document
> renesas,poegs property
>=20
>=20
> On Fri, 11 Nov 2022 19:29:41 +0000, Biju Das wrote:
> > RZ/G2L GPT IP supports output pin disable function by dead time error
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
> >  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml:
> properties:renesas,poegs:items: 'oneOf' conditional failed, one must be
> fixed:
> 	{'maxItems': 8, 'minItems': 1, 'items': [{'description': 'phandle to
> POEG instance that serves the output disable'}, {'enum': [0, 1, 2, 3, 4, =
5,
> 6, 7], 'description': 'An index identifying pair of GPT channels.\n  <0> =
:
> GPT channels 0 and 1\n  <1> : GPT channels 2 and 3\n  <2> : GPT channels =
4
> and 5\n  <3> : GPT channels 6 and 7\n  <4> : GPT channels 8 and 9\n  <5> =
:
> GPT channels 10 and 11\n  <6> : GPT channels 12 and 13\n  <7> : GPT chann=
els
> 14 and 15\n'}]} should not be valid under {'required': ['maxItems']}
> 		hint: "maxItems" is not needed with an "items" list
> 	{'maxItems': 8, 'minItems': 1, 'items': [{'description': 'phandle to
> POEG instance that serves the output disable'}, {'enum': [0, 1, 2, 3, 4, =
5,
> 6, 7], 'description': 'An index identifying pair of GPT channels.\n  <0> =
:
> GPT channels 0 and 1\n  <1> : GPT channels 2 and 3\n  <2> : GPT channels =
4
> and 5\n  <3> : GPT channels 6 and 7\n  <4> : GPT channels 8 and 9\n  <5> =
:
> GPT channels 10 and 11\n  <6> : GPT channels 12 and 13\n  <7> : GPT chann=
els
> 14 and 15\n'}]} is not of type 'array'
> 	from schema $id:
>=20
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

I am able to reproduce the issue reported by bot[1]. Looks like we should n=
ot add maxItems for Items.
The check is passing, if we just add minItems for Items.

Please let me know shall I drop maxItems and just add minItems with an "ite=
ms" list?

Or

Drop both from "items" list.


[1]
~/dt-binding-check.sh Documentation/devicetree/bindings/pwm/renesas,rzg2l-g=
pt.yaml
bindings file ###  Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.=
yaml ####
checking bindings
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
/home/biju/renesas-devel/Documentation/devicetree/bindings/pwm/renesas,rzg2=
l-gpt.yaml: properties:renesas,poegs:items: 'oneOf' conditional failed, one=
 must be fixed:
	{'maxItems': 8, 'minItems': 1, 'items': [{'description': 'phandle to POEG =
instance that serves the output disable'}, {'enum': [0, 1, 2, 3, 4, 5, 6, 7=
], 'description': 'An index identifying pair of GPT channels.\n  <0> : GPT =
channels 0 and 1\n  <1> : GPT channels 2 and 3\n  <2> : GPT channels 4 and =
5\n  <3> : GPT channels 6 and 7\n  <4> : GPT channels 8 and 9\n  <5> : GPT =
channels 10 and 11\n  <6> : GPT channels 12 and 13\n  <7> : GPT channels 14=
 and 15\n'}]} should not be valid under {'required': ['maxItems']}
		hint: "maxItems" is not needed with an "items" list
	{'maxItems': 8, 'minItems': 1, 'items': [{'description': 'phandle to POEG =
instance that serves the output disable'}, {'enum': [0, 1, 2, 3, 4, 5, 6, 7=
], 'description': 'An index identifying pair of GPT channels.\n  <0> : GPT =
channels 0 and 1\n  <1> : GPT channels 2 and 3\n  <2> : GPT channels 4 and =
5\n  <3> : GPT channels 6 and 7\n  <4> : GPT channels 8 and 9\n  <5> : GPT =
channels 10 and 11\n  <6> : GPT channels 12 and 13\n  <7> : GPT channels 14=
 and 15\n'}]} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.example.d=
tb

Cheers,
Biju

