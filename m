Return-Path: <linux-pwm+bounces-4288-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46519E871B
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Dec 2024 18:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777F2281399
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Dec 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611EF175D5A;
	Sun,  8 Dec 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Ti7AxuVg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011007.outbound.protection.outlook.com [40.107.74.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473D22EE4;
	Sun,  8 Dec 2024 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733679496; cv=fail; b=GV5V46/5AtVYcbCPOv9EGWJWD90WMdssKKfjp6VQYvhpNBXo76c0NaaPKfgb7LKVWGQ/OxZEN4Idu/QRmppQEDG5lLUMltmTkGXmMXilllcrcOwiexNWulTTIryScB0h3KGuSRwz4abekD7GB4om8Ob+wuA8cjKmTyDMdqaAJjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733679496; c=relaxed/simple;
	bh=g5VjFqyO0U7ANI+Q442gEKoGpsVdM9MutnfWm/lqaEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YfS/vOvqLJur2YF1FY0MNLgtVlwBEKVwY3bGpwN6JhBSLsIeec/ScO/ImfI7/D2OPQRgPbgImlNmupa5p/dAGl7DTUXsSACAlB7fFfOxP0VyzmbTT8rxsPVeDWd5n+assdo6fCcrbDQIiU448uPwuNcG8VWvYBnwRHELKoaHd7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Ti7AxuVg; arc=fail smtp.client-ip=40.107.74.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2fUVGa6uiix8ZQYFM07iZttMOESKAzPMwHPjJizo9EB6oiZdmwaZWtpfJQ8HUagLC1/4xNBm3Xu9+P+KpFrxE938r+7dbCu3LejiGokIkHyUi1EZ/tFzKyLz0y7a3+Nci8Pp0BtB92LBqNt7EuHg78mF0vdgWy+S8b0PeuIeQFKX/mxntvIDNc/e1kGCFthYX7e9GA73oYLo0hVp7VSZmMQ4tlsdgtjGY7NizASXyW9p0N/SdTTD+BWNS5GpSjmjdn/K5Y9mVnjQxyH5g6nzQeXnmBXD49uC49zgvuIHTxl/nU4/xoaIQ1U4Xv8GxVUVRgXsawrMkCBwyITgaydpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H36maZiRqbACneMLxxNBIWBGDGnrMWIzT7k9lOUQCqQ=;
 b=Zlt6G7zMAAmxcFl/0xrnTIqQAVEkGDa64QaFIQfaRpxm0PbHHBiQFpA6bTPiUZyan5CIlecs6n+JVgYa5VnygbC7ogmSs7qjNE8pjDUx/4FiRlc0hueBbf37DQl5YPbKFRDrifGK4gF05v0qf9WdZlP3O+q943y8uWeWBOmC84ymqsZtD9aAedjY0CoFshScamMH3PSzDiyclK4OPEMs1G07t3bBFJFPkWR9D1UJXlAfLtt6Zd0MxOxpCDKFdB53uiipjNb2eq44rmgv1cKsptAlRB4OCEvRDrLl4g2o+DyFa4NgcnSfv5f4+0/KADRknktiDT/ionrnVfoiL87HHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H36maZiRqbACneMLxxNBIWBGDGnrMWIzT7k9lOUQCqQ=;
 b=Ti7AxuVg4HFCqwn47WTjSSEnQGx3lERlACswcNELKrx7MoLzvr3G9lKOx3YvTGJEm++KrP/m4z/uBoZl5BtyVKiUzp/6elO3x/JP2yfPTcmhpMgOFWqRv9Ip7TowYeD5vZ0DG7qUWgoJvb4ykvrNkIr67NQSMP4mjJsaHREPBHY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB9690.jpnprd01.prod.outlook.com (2603:1096:604:1e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Sun, 8 Dec
 2024 17:38:08 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8207.014; Sun, 8 Dec 2024
 17:38:07 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index:
 AQHbIV3QCLVSX2/XSk+pOZR0ZimyzrLORWwAgAhm5eCAAPAoAIAADXnAgAB4SoCABMQ7gA==
Date: Sun, 8 Dec 2024 17:38:07 +0000
Message-ID:
 <TY3PR01MB11346DB83246B0A7DDFBDFE6986332@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-4-biju.das.jz@bp.renesas.com>
 <slgs56imb3u6fv35bo2hl4moa77nnhrtcygi4womtuzs2mcipt@ylcvacvhsgcl>
 <TY3PR01MB11346421B5C0C4A193F70C3A586372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <phr4mtucfmyuhaywspzpxwqvwmklwcgsljcc5dvzbft44kengw@65axncbiotf7>
 <TY3PR01MB11346E660F70645F04F67F67686302@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <mgc7ioulqxj6ht5rajpehblpattrojby4e3ashqvhxcrn5fszh@7steb6p27xtc>
In-Reply-To: <mgc7ioulqxj6ht5rajpehblpattrojby4e3ashqvhxcrn5fszh@7steb6p27xtc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB9690:EE_
x-ms-office365-filtering-correlation-id: e8f04818-d31e-43f2-b154-08dd17af13a0
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LyapxrKebk3w+s9f6SbxDY571NrrmphMWobYM5fhBi9gTkJ+PRUZOyvEeA?=
 =?iso-8859-1?Q?ky0GYnqSDrjqWYYH/KRov7UjPl0ZYJ7kpf/10O4HioLxQdKgKK2/tsJQlz?=
 =?iso-8859-1?Q?1EnwNfCP4zBZCRlpqo8zrcTWez6wPGk/z6icO3l6wyUUy54lhRLUKLaC/Y?=
 =?iso-8859-1?Q?21q2ucZioA8svfwa8Nte7Mf9+2VaVbh7KdqpKJV7h4SqiLABK3Cwhuf7JT?=
 =?iso-8859-1?Q?W4HTi5W2ilBXov9N4Ta2xiDJKc6C3H9WLng1z1xEJtj3DhjlU3vM7dpq31?=
 =?iso-8859-1?Q?BY7rVAiUVhtI/uvTUfj1ocGWJajukba2FIL9/G9WzZv2gKuAHrdT3F3Rbt?=
 =?iso-8859-1?Q?S0gFBvrZMeXbJsROETtnKXLIsaQyUzGu3tvzlew0TtuhAjjvZcg4Fp9kFe?=
 =?iso-8859-1?Q?PLzN05BBkj8xB7FRGXbdtK66WtIHALYrV4C2pMR7XhzZyEDoHfAfeq3sfF?=
 =?iso-8859-1?Q?SM9mikZyrfRsP8VV8a8FLluFNudMmeV+2yP0PlfjWfAa/tjz59YkvkGpAR?=
 =?iso-8859-1?Q?+f9PpPCvC46ykzbtf8cUDjkhRMS1yrqC3Y1Kljkh0Vc9lHNrt8hI8oBgDR?=
 =?iso-8859-1?Q?5KG6+0pCYfnkA5NaEalgb0iGM1OtVfYzC2JhiOyI63mAJVl7+MsvhO/Cbx?=
 =?iso-8859-1?Q?+IAQNvbY8lYs3IHBey9XLl2TFKYtyiIWZ5JY2w77yxEfPOaxrCwfz5iYWw?=
 =?iso-8859-1?Q?+vNqI4fj2lVqukDJ4c9gHW2/red7m6uaLvjTku84v5sRCGdJ+LFqUZxkxr?=
 =?iso-8859-1?Q?Tf+Y3uFcuoqC1u9JRxCyuHhpb0wNX+LkOSTlJcB8pai849mpuzl3AHLvFv?=
 =?iso-8859-1?Q?swNPPg5gf/QCF+kd7KSRVdPXSthf4R6CEG7EcJRJeEe4njtXNOPc+d5XkC?=
 =?iso-8859-1?Q?Jt2wjCAUBFeD1K00/dwmvieVLbU/0N9LV2CtjQir4byjzYz42n6xd1XgrK?=
 =?iso-8859-1?Q?E0L/0t/f+fafVpT8B/ZLNgp/Sr0H+NyAydUYoGB+6i3Pap/7NmfoVf8lBN?=
 =?iso-8859-1?Q?FJosAskDGRxOgPkZ5A2KAMzjP1Ix7CuwmPnZAfNLBUUz77EhKuQxmLc/NO?=
 =?iso-8859-1?Q?ILs35YN0I0u4m3mUXADgo0MZpNLuYIaRg5QBeQxtAeTtIbZlHZxN5jMhuN?=
 =?iso-8859-1?Q?m0zCFKM/xgKWJmEe5GK5i7q/Qys4/LDfahfjK0iy9nQmUIqy1+B5rccXRy?=
 =?iso-8859-1?Q?CAQCnL9sK8djuJB81NxWCQGZOKuaKd1D68ZFKQeGt6Sl8BPxEPNpT9TGjS?=
 =?iso-8859-1?Q?ScUjIfm2pupE7a8ApnoDVFkgojGtZeQ9E+idL2/z1q93ic5pfI/azac+HZ?=
 =?iso-8859-1?Q?MHMgCVhscWJ4Z5M9GyrpL0+gf8mNIFYDC5UiyB6SU8B0GPiWwLJX72GG8g?=
 =?iso-8859-1?Q?pXcPQ8GOri3wdvQtvnommzjWrPb5WhAofM9+BhulSmNWjiJAC0ly+W7KJz?=
 =?iso-8859-1?Q?Me+jnmRlJHA5TuOQ01UWaZeubIazBAAP7/CjCQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3I1eQAmFcosc6jNt0Ua+8pgeYMSbNqb99bcwTARHJMmHdjAZhtzHVmhnkb?=
 =?iso-8859-1?Q?+hYzRKQxROCnYi+EcrW8hrb92WQcgv3FJJPVgTpy/tR5Y1oOyZVyF9XIv9?=
 =?iso-8859-1?Q?skD15CxkyOVyuEcVedqMHguPup0A/P43RVGA6U71/qu+Mkwj6emK7YWNWd?=
 =?iso-8859-1?Q?R2BZookZ4IxnWfyR/F/rk+gFIfQ/RuxkpZapf7RtH67NfWi/YAwyaaKoBm?=
 =?iso-8859-1?Q?6PqdBF8Y6HXXvcj9vd2sEr5N4gesVxjuXdazQe1PIZNbV2j+J6OXvKJqwu?=
 =?iso-8859-1?Q?+s5kPKYTCQHBHKnpaN3fxjD9L5OtzGlYlitl4DTO4ID8rId0gScT8HB8Jr?=
 =?iso-8859-1?Q?cVqQNP6TQgdm48iMSfUkbFXtyImCQXE/YezaifQj5AwJwXxkXvdBElvBjK?=
 =?iso-8859-1?Q?mUwCQxcOmoD6m5uyBl6vEsYyUAvNxtPAGXwlDXvSQBO2AZufWKwb+xP7aT?=
 =?iso-8859-1?Q?Xxb2KhHStZXWj8DoW928he9k+07/wfxF2Arr0sgOV/R84A61Ydm7ci7t1H?=
 =?iso-8859-1?Q?JWef2TCZkWoDSZvbdtxYqGcbeza9t5hpWLTymAPwuVctnqC+glqJOwiO3j?=
 =?iso-8859-1?Q?x7kYkwiLmaQX61KcrQWZlWS+VMWjjAYT9Ysjgxj8wAZ8TmeADC7GSfwBDc?=
 =?iso-8859-1?Q?v0fvjz+3wXLMqcXsIrGaxMoUxg7zCLkjtbkNpSBOlzy/0D60tkjRl3bM4a?=
 =?iso-8859-1?Q?CMteDCPLZJ56zFoLkqih/mS8DxTR6BA25JkEHAjwOakxtE+MvlcsRF2hpc?=
 =?iso-8859-1?Q?3z6/LRt99AL7kSzeM4dMi5j2ld863zAOe83Z49fyexXQuuCNqXNFOhIwgX?=
 =?iso-8859-1?Q?fRGQDHXHMTj08oCms00E5Sr48CvPKessZCIHOaLryFlJ1TEQsaLy2lBd+e?=
 =?iso-8859-1?Q?A6gtxDuBxau/vUFMsmuxBgosr0EEzDFI31d/1KXkn0O9imdzsI3Mwqn3Qh?=
 =?iso-8859-1?Q?91U1nf1Elr+g8FihmJuWgZR4dbE803b5rwpMrKs0VXFNjtL1e6iEPmDWWW?=
 =?iso-8859-1?Q?wvwUvEVBXjml3SSQ67Obj8T8jU7/vxjqS+GGAUVPooufPrgLQVjwqjKsR5?=
 =?iso-8859-1?Q?iA9CrQPv3cOae6iY4IjkZIO63CaQdzWvDBQaMF3GIT2mbsRqSftrdHoydO?=
 =?iso-8859-1?Q?MYH+oMG4jmfD6LPA1/atvbqDYbZcJ27H4ln40HxMNB3+w+8D5MDA8Nty0k?=
 =?iso-8859-1?Q?nTj2k9n2s96tykEP03U2uLmBRMSaURsxio+Y5CEFvrHH67f1CF/dJqGVu8?=
 =?iso-8859-1?Q?CEIrfBn9Qaa2UHQWGqBvMKSE1M3Mw9L6OWl+QA4iZfkAvD4IZk/TMofZSd?=
 =?iso-8859-1?Q?t71aro6xGcA+4eZMYU1pm0Kaucstob1joFQ11tBDb9/S73ivgcpwc7JCvd?=
 =?iso-8859-1?Q?BXVm/N3LrwWB/eQxdUr7tvMMDVdfYl/Mp3J3c6EP6oH6JgEaSi6HW445EQ?=
 =?iso-8859-1?Q?4cfycLABXH9iS8yjvN1HivL5VwdP9j6JkVDHAToeU5PZ6NZ6SSLD42lAjC?=
 =?iso-8859-1?Q?u/52fzyMFvgGM9AAkMlNJUOg77U65bnZc2xCyNpmkdgAOujk+JhyZOvzu9?=
 =?iso-8859-1?Q?cDj5sQx1kGoPResKBEMAmBiotwSEpfMqhZUqaj3wiQn58bG6wLT3DDFmu/?=
 =?iso-8859-1?Q?Oxu5cyJpK8JIuF3qa0a3jL77385FN9q7eVaQy8d6qnqY1YbuW9Sc/oBg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f04818-d31e-43f2-b154-08dd17af13a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2024 17:38:07.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TOtvR2BKYaL/QecuI81DCVM+23aXfqXkeRqsw1RleZqpEfT3I+Ttz52wB2x9Q+EsYX9odbYb1DsmFFMLDqb0Dd7NZscwLEpm4WzMIqWHKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9690

Hi Uwe Kleine-K=F6nig,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 05 December 2024 16:27
> Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Thu, Dec 05, 2024 at 09:29:35AM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > > Sent: 05 December 2024 08:28
> > > Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
> > >
> > > Hello Biju,
> > >
> > > > According to me, we should not allow updating periods for second en=
abled channel.
> > >
> > > Not entirely sure you mean the right thing here. If IO A operates at
> > > 5ns and IO B is requested to set .period =3D 5 ms, every operation th=
at also changes A is out-of-
> bounds. So your options are only:
> > > Use the 5ns, or return an error. The latter is hard for consumers
> > > because it's unclear what to do then.
> >
> >
> > I guess, these 2 IO's mostly used in switching circuits. So, can't we r=
eturn error, if period of
> IO_A !=3D IO_B?
> > Then the user know the mistake and he will configure with proper values=
??
>=20
> You can do that. However in general the user (or consumer driver) of IO A=
 won't know about the
> connection between the two PWMs and so they only see their request failin=
g.

Ok, thanks. This will make the driver simpler for the initial version.

>=20
> > Here IO_B has faster switching(MHz) compared to IO_A (kHZ), So, by
> > allowing IO_A to operate at IO_B frequency, we are doing Some
> > incorrect operation for IO_A.
>=20
> "incorrect" is very subjective and depends on the use case. Many drivers =
only care about the relative

Sorry for my bad english.

> duty cycle. So if they initially want
>=20
> 	.duty_cycle =3D 1ms
> 	.period =3D 5ms
>=20
> and then learn that only period =3D 5ns is possible, they are also happy =
with
>=20
> 	.duty_cycle =3D 1ns
> 	.period =3D 5ns
>=20
> Some other drivers are happy with a given duty cycle and hardly care abou=
t the period, so they only
> care that .duty_cycle is 3ns and both .period =3D 5ms and .period =3D 5ns=
 is ok.
>=20
> Or a driver that requests
>=20
> 	.duty_cycle =3D 0ms
> 	.period =3D 5ms
>=20
> doesn't care about the period at all if only .duty_cycle is zero.
>=20
> So the only way to make everybody happy, is to be able to query the hardw=
are possibilities.

I got your point a duty cycle of 50% can be achieved at period/duty configu=
red at ms or in nsec.

The former being aimed for low frequency PWM application and later for high=
er frequency
application and the period in ms or nsec are purely application specific.

If you allow me, Shall I send simplified version of the driver? ie, will re=
turn
error if requested_period of IO_A !=3D IO_B.


Later we can accommodate adapting duty cycle of first channel, if we allow =
changing
periods from second channel, based on any customer use case. There are some=
 customers
using GPT for backlight in LCD panels.

Please let me know.

Going forward there are lot of features are planned for this driver
1) inverse feature
2) Detecting short circuits between IO's
3) Phase counting
4) Input capture
5) PWM using buffer
6) DMA operation
7) ADC start trigger

Cheers,
Biju

