Return-Path: <linux-pwm+bounces-4156-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B49DC116
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 10:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2547C163E68
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08E175D35;
	Fri, 29 Nov 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="oMyv2Uzl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010054.outbound.protection.outlook.com [52.101.229.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47C1598EE;
	Fri, 29 Nov 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871409; cv=fail; b=ryyU3lYzddbJTB5mLtw6Xs7HdnMLAKyD1knJJ7+96yS9JlMi2fmW0IgMTgB29xff1V0hVYlnKDarsbU/SHRnam2aVNlLP6hur/uRKj0lUMbs6deGVzXSqAkvA806MrR/J/dEmrNJql9Z/mPNo7aYX87wT8F9Vrmxy91Lm0BghOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871409; c=relaxed/simple;
	bh=I3PzPIaN713WwNKBfCzHNtP1T3XJUcmSJ/S5EhpjYTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Or9Lt2+iew8XgQaA8Re2UlUh4zx2SPhlBhOdvInyEfS5Qtx24WpzNH/OxW+djNUfFfzetWEGV4rwtucX4AvkwSX1YJGhKG6ETx863C6dFK5B1gupyKTDt0/M/Wp3g0hSNpYbgYGJk8qCBtV+zpjWZSBuK5/86bXv6+ai1D/PSek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=oMyv2Uzl; arc=fail smtp.client-ip=52.101.229.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THjW3nyAOoOL1g2YMBPKa0OK0XhetaQWIcGU3ysR42jH2gF23wd9zE7HhC35UHq2ug2xHoS1iDYzsPx+gNZflzRz3y1vyeIWJdXAXsFbthwg9xAKGVsD5aCEUzdD320ZhiGS9mhrO0OO4w2NQAhNWdUPLkvyKVWKydd5+8EgMc+GXP5bRWZYbmp7FhOZh982+e0M1vKs9iUxcRdE5d77PL7i0GsDdh3nSHHbaDePas0/POfLnhHBVrKVpX5YzQpvzLxADdfXeSUr1sbOZEuJF+xMWSqH5YJPFuHi+mDQdg2HjpZXth1aMHdYXGlQ4CtAVW/W22L3XQ02Y8OyltO4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt6Ma4Dh0E1Jw1GOkxtW6COllW6mzyAT39JTFyI5hGs=;
 b=DDql/LB6ucu1m1dkm/NJHcZI5K2mPq4nnZqDZqMx8l4o2P+dgynzg4KuyMGwj2nIK4N+txEtFTU9NXFVaHaQCrzytuniQXErLZvOjm495Z66tVDEEtjZtOwhIgA2ztu4+eT0Vyiz3vZHfAgxrdvkMFJ7ha9IlKMbdAcc7PMRBn7oCor0qnIridUuiPhHroi4P0P6BdXKjvh1Fkqxyqk3zzvfnt/BwpLbHQ8zjQTdR0Z08cR5tWiAEj/h95AwO93QQuMSNtLryrUDnmhQZPjN7qazLNZl4YtJMtyPNmYRH0ECzquo91p7Ax0aV6F9h7bgdWI6LcxEWSAnQM9GXTRkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt6Ma4Dh0E1Jw1GOkxtW6COllW6mzyAT39JTFyI5hGs=;
 b=oMyv2UzlxVqMnWU0q8GIMphkS6zkp/swDyKiUd/Xzotz4wtfI7Ih27Sk1AURKLb6tadiDz14uSdqhpYlhQb2uCkdANPkNe45aLO1y8FvFpFba39QWx/Xf38qghSKBAvZVvW14Z1Jn7j12fRJp7JaoDPDGSsSyS3kdzUiiBnufV4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12286.jpnprd01.prod.outlook.com (2603:1096:405:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 09:10:02 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 09:10:02 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v22 1/4] dt-bindings: pwm: Add RZ/G2L GPT binding
Thread-Topic: [PATCH v22 1/4] dt-bindings: pwm: Add RZ/G2L GPT binding
Thread-Index: AQHbIV3Lpg5iNtSVhUWmW/xtiT9B0bLONOWAgAAD4QA=
Date: Fri, 29 Nov 2024 09:10:02 +0000
Message-ID:
 <TY3PR01MB113469F250419F13DCBB9A95D862A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-2-biju.das.jz@bp.renesas.com>
 <7r7euw7h5fln3y5hy3zkrm4n4fafh5ww3ydxnwcpcjhbpb5vza@fleninlwsaqb>
In-Reply-To: <7r7euw7h5fln3y5hy3zkrm4n4fafh5ww3ydxnwcpcjhbpb5vza@fleninlwsaqb>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12286:EE_
x-ms-office365-filtering-correlation-id: e3501473-def9-427f-eeb1-08dd10559b6a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?acTPj6rQjRErf7d8lqXZZ21ZT+uyb692H6RI1UREYPv+aPB73LbFrsfwBH?=
 =?iso-8859-1?Q?HF5xnIWTZ4AK56AhBbEZ+61LmY7TLM4ncaqp8ogquLTRbGZx5L4fiEleJz?=
 =?iso-8859-1?Q?tDXko+xttFoGlL4dALKOSx8Ot1GB3SGd6JHUd/FkeuBYK7d1pDFfGS4IVU?=
 =?iso-8859-1?Q?n6fkq8xwr4a+Z2h3dd1DYXc+Dgn0fhAseq5MA8tD9vLrIXuE/YvC0jZrCV?=
 =?iso-8859-1?Q?u614e8yKiyJu8wYbXfF0+rhlkIa0gD9+mxiKQCO9qW7ZwsEne2peMCkpEs?=
 =?iso-8859-1?Q?Js0VxRFWTqSY+zfXV7nhKUyAnSKaTRoF/wOistKmdhnzWz96iKoAsNLhYu?=
 =?iso-8859-1?Q?QpRundrbdCcJOkMXDCPcR6dKXei/uB5OnwLtjDCnyDjh1bPEw7zJPo/pCt?=
 =?iso-8859-1?Q?/O2Qe/EmMzZL3k0ZxnQCpDdnxmvqkzFwOF3yXwB/lyXETXO2LwDrSfSRa+?=
 =?iso-8859-1?Q?99+EfyiLAFkHgwUVPIsgs6tsKihbdGqq3YJ7y4SKqxTL6G8QCncI1r7bDt?=
 =?iso-8859-1?Q?DZ4BwQzZ/3vl7d+UyK0IlnnJCa2hIZ7NGcZy0My0C1eC3KgoaaEq/Ilmle?=
 =?iso-8859-1?Q?cI+OAlyuM2umykKKB3WBavSmlQNiMhK8whwWNqnxw4DoAFRdEChONyucP/?=
 =?iso-8859-1?Q?UJMPLqgTTzW01nTBafxzv/iIn88jfxGXeooZMJ5B6a11AtIwAhPjLd56kT?=
 =?iso-8859-1?Q?JoDHQhXyolS03K4tccphQN7ZAibcOzXbHKWW3g6kJkyam1kCnZrEcB2eKP?=
 =?iso-8859-1?Q?KB5lIXLZhnv0PGHUs33gU+iJJSHnBc0016GI0IDALA3RjEqvVAympJ62On?=
 =?iso-8859-1?Q?O576CUtGrdIwGdfPHPNd7oKIEbOuC2fAqbvw7NtLmm8VPVJFp+eaBvkWEA?=
 =?iso-8859-1?Q?YN2rhQf+OB7vUzIp4IbF8bjEbyFHLHErCR8EKKLDktPWgpj+eZ9ssljo2i?=
 =?iso-8859-1?Q?QQ54wZQ/BnrzfGGR1iXVfJ7Mt5mH2HstbszylAIl7VsgwReeWF0e+EE39D?=
 =?iso-8859-1?Q?9Z9wlygrEH7caTFXndLIQl6GXXu+rim41uSPTIK7xgxunrcQkh+DSQpvng?=
 =?iso-8859-1?Q?F3snfL7NhnUlZlGzB8LaZlUhTjjB2ZPvfOh/TiiWZZnUZRgkQd6U70Az9E?=
 =?iso-8859-1?Q?xNdp325UXxfBj7utQK8Ebzh6d2rUqy/t7pkAo3Faao6MVmYn8KSa3wvJXv?=
 =?iso-8859-1?Q?aq4Nf17TWyEjRA6qV35edJ0W0Dx4W+j0gS7mHu70b2dZV8UNSSbYoQsl/I?=
 =?iso-8859-1?Q?s338J4RSx+ozsuXE7jIf6e8tcpLs6J+o2D6Dco3BdJm+ERRAdbRy1NsIwY?=
 =?iso-8859-1?Q?59b1H6NTNW94rD58ZXU98vBd5Hc+xYovNqviFEzb+vzG9Cqbyin2GTr90q?=
 =?iso-8859-1?Q?unP0S7shqWmB0/siepfml5JeLxtnPmg8qNgBMdFQa+F1KEHvbUE8n3v+FC?=
 =?iso-8859-1?Q?Hqb4TCTfpd/0tk2UC60lgFzInOgrYdQydUS95w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?D95BHq+h1fljY7s9IQDd33pw5rNPOOLqC44/B7F6p4bGhwxnPKYS6hvhOR?=
 =?iso-8859-1?Q?ZoT3QbX4UK7Y1l/zAX2IyzWkM6IJ3PsBBbnwjlzZDj6rVgrMzUY1wSD+V/?=
 =?iso-8859-1?Q?TNscpVDNNYhwm3TL14XPCd+vE4oj/kqS/aDDT+8SetQBByPlLAepCUtfcR?=
 =?iso-8859-1?Q?KssqZjKO1DHZcSxlJc5QmagnJxpKg41y+t4b9FEa4m9CVFou0qkeuqUJMY?=
 =?iso-8859-1?Q?iaQoVmiL8CUlJaVeGBNq9Re5dy179v/h0KNPbEzxEfnMtNj+aHBr9R8+yO?=
 =?iso-8859-1?Q?LcELqav/yL1G7esAVXgXghV46Q/wLWI8mOARGd6WpvIznaolsTCAo5l872?=
 =?iso-8859-1?Q?7mnUMZ9ZrUTPMlOAnOoWS/lyJ8F7dHMk4ytZZpLMs9UUEXtQ/gzDbYc3x9?=
 =?iso-8859-1?Q?xdOUbhVYMmwXk3odvQ7SVwYFQPUO+SIQwqAiCxPisw6vxcnIX09Bmgw7zi?=
 =?iso-8859-1?Q?HGQCggU6JV3hiYmGSghqmk+H9X8aovg4QU03b3MtTxiBk6e3YqBn3HJCY5?=
 =?iso-8859-1?Q?9JYl7yMQIi+y7Z6Hjo34HgB8P0Dh3kaUVSgQjCaVIjgeyo+oc1X1pC+5dL?=
 =?iso-8859-1?Q?FKJwQA4A0wbQkndmZSVJGTZFcqgffNO9jPKNpJ12InMqUoO9J2YQOcESBq?=
 =?iso-8859-1?Q?XVUMKzPqR7y2u+nLcz1oPvPr40gDI2sl+lA12SYD02OF2yw3jdPQyFrbbG?=
 =?iso-8859-1?Q?1hR6S1lkrSeYTqnIX/na4CJltVaSYdPpsVsbXNvdZeCX6wDSXTffsKc1eK?=
 =?iso-8859-1?Q?kH9RqI6HzRtGh63yamwa/FFD1rO7uYeV6ekMUvkr4lh5JIYLK8/r7H6LOj?=
 =?iso-8859-1?Q?HX/xckRl3iCW9CX9/mBPqRFdpzZSb6+QD9b5UnneLV8W8EGmc78hx+CWS2?=
 =?iso-8859-1?Q?rNeRWp1QESQGtt39xGBQIXtQxc258pokCxRuco60M5SGZyTsIuSZmvO84e?=
 =?iso-8859-1?Q?T/P0bYexZztfUgnOJdm3PEq1IYmU23oaRX3yu1W7McuXiB/m+ofvRphFTL?=
 =?iso-8859-1?Q?wNUoZEDtIQqTBM8XY/Hnaa9yiVD1kAg3tzsHe4cREgqEeaUfyxWocrE7na?=
 =?iso-8859-1?Q?gJrf+nEoTB3wB/XH0InuWX4fxy95JFNOLgCgJBAi8iH1eOeytJPm1euJ6A?=
 =?iso-8859-1?Q?eJzyb55sOkqahOHidjDpmRsHsTJGJLRxn8SNcgqobg3Ri85untyKKNE4nn?=
 =?iso-8859-1?Q?cRuhpT5t1lPgrCqT9kOnbZKhag5mROoKofcmf+BZgRMZ1zlOx+mJwObUYU?=
 =?iso-8859-1?Q?oucrkmmZE3eJnoHx9i/tAjliRoFZdzFLLb1rFI4Zvvy3VdjJZcwaY328uM?=
 =?iso-8859-1?Q?YR91APa6YuOnLTJTRESVyHAc0PazsWY5I552D2XjdXqMMPMObdnlRASYLj?=
 =?iso-8859-1?Q?4yIYWqcMA+Errf6cRqKJsQ64keQmYPE3Eyx4sAoQ+j9b8XK2acBWhSGDRs?=
 =?iso-8859-1?Q?dmGxdD+0TM1A/kKiVmp2Slu3LIqp0TN3oHpSZFtPQ6ik6gTQlIjVRfxa40?=
 =?iso-8859-1?Q?64sy3lMRO6atVBdBxJoRllTPz6ZENbVqqnRxZ9RpeZNrb2pDbfzYmwYR3l?=
 =?iso-8859-1?Q?lKYQ1gqtmfquRiBAUdKpDagROGxyR9GAgkG7DSixMKjS+AeQRr2lYbVGSJ?=
 =?iso-8859-1?Q?6XBNkJAwGqIcXmUfRQnCWjjfpHeyb7pp2K+QCxcHq9Tj9bIyONgUCyJg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3501473-def9-427f-eeb1-08dd10559b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 09:10:02.1779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZCQ+WWLtJ7tynMW4dJQaGAchpoffD3KO2i89rPf6SgV6zHOwIgmMyEJk9J6sZFs+MAWtDJazewiCrYHh7IjsSHJbqwpV8JFaz73KayoAwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12286

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 29 November 2024 08:51
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH v22 1/4] dt-bindings: pwm: Add RZ/G2L GPT binding
>=20
> On Fri, Oct 18, 2024 at 02:00:42PM +0100, Biju Das wrote:
> >  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 378 ++++++++++++++++++
> >  1 file changed, 378 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l=
-gpt.yaml
>=20
> Wow, quite a big binding. An astonishing amount of irqs.
>=20
> > [...]
> > +  '#pwm-cells':
> > +    const: 2
>=20
> Please make this 3. Otherwise no objections.

The hardware supports both polarities. Currently I have added support for n=
ormal polarity.
Subsequent patch will enable inverse polarity.=20

Am I missing something here? Please let me know.

Or

since it is optional, there is no harm in making it to 3 to take care
of any future additions in pwm.h flags.

Cheers,
Biju

