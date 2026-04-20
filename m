Return-Path: <linux-pwm+bounces-8660-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBWGFl5v5mmBwAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8660-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 20:24:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33E432C96
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 20:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DD1A30334BC
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B43D3859EF;
	Mon, 20 Apr 2026 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UJ2EQzr3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010063.outbound.protection.outlook.com [52.101.229.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A739F16D;
	Mon, 20 Apr 2026 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707557; cv=fail; b=BTSK0OZDs3z0y3Zu7pPsSrYijsnBBY/cr8RmyrzhM30VKjQVwQwjEQcUXPdiycqJcrmTmp3fa6tNJjfZ7KzbYNYxvtLgFwFWTX+tQH2cjSA5j33nwuLa9/kGISVluzrOgzHcLo1xxbTWGfgYhhvIcYdpEluW4MdL+Gxi4aGqRoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707557; c=relaxed/simple;
	bh=9dgY1YzMK7y67Xbbf8caFQzRYxyUBtaXYDls50XemTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=esdV70CYmZ6c2sdDaOx39wSjyoiuxa7AsfRUFFzSxhfw9hwSvfVf8IeFeGpWyXmnMaLClYL5dfKFEfD7FtwTv0kYR38RDtLE/Hvj8u9+BGBP0LTQ7gMC/DjxFXAJL0GW5/fns7DoEdeAkUI0EfwmvQq9hjlQGwsY5MGNwlEt37E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=UJ2EQzr3; arc=fail smtp.client-ip=52.101.229.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq0tVMPFJIU+YeMV2aL8rQt8THkxgmQIO7wwMiKdXfR8XsI9paOs/N2SZuT2F95HoNxwS0O1ZVmS/f2xiyVJO5d/OjT4Q5IHeKKHZSaK1lsQBzUW6dIsXxe8u1I1xIM8SHAHJ1oCTp1YbPTlhC2SRx+aPeNraciTpmhPeLffZ2K2Gx9cieZY8Tqj9J8mBP+HhXzCHeJZdTe2DOD0zHWShMsejikfLod0aQM/S4WvIMzJxo/WCUAWWnAQYcYMiLfH2aTYSVwJ8PWc6mi08TM0TBR2ueaRZJ+F5OzbGZ4dZiqujcLKMOWfdp2ZaoAgu4oZH4Fx5PQLrTw+reH0xyOLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QAjcfdSnlP4qQz4bNvdK0oe5PUmnsXDo0TpTJygN5Y=;
 b=mcnTt6ZfZAc+zpZsA54joe8fhngFYLCFkh/AZfyMFfQNnTA5QNLM8EL34nDYV3fyAk8W4FBE7W+jS14smGav9zr43ivU8dDC1FkbeK9M3Emmc+lBEyxJuRv3y5kAtR4ZQCVvxHH8ebHKqLLcSIynUbUdx09Tuq3xHJNV+/bRrqBjydfxCWkpoDwVdCOLMlx+mdBXIo12PdIuoANcOlGlgHTm0Zq6A2hOHs/zZTFV9e1K26Wge5yp7SEkxbKO7Ah9PzL30DNmJVkIjpIOnjfBALGuVykg+Wz6J1BDKjLf2XW8NrMzlt7Q/10Oq1oXzX+Gr0pe7QqgnSPb4mmJLFX/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QAjcfdSnlP4qQz4bNvdK0oe5PUmnsXDo0TpTJygN5Y=;
 b=UJ2EQzr3jo/dVvzo5PxeTfcr81aIypOhbHe0L8voy/Fmq1m1yivn8A0jlBk11TUORfyjXusb+Ld3XVgrVkiUCQCcX/sQttdCfiFWVajKC+wFVxs8bYBywAg9zc0LPR+a7n7A9fDdbTAqpk5YaP3CBHIesgA0OFeCM654J8MNBbU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB17044.jpnprd01.prod.outlook.com (2603:1096:604:40d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 17:52:32 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 17:52:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<ukleinek@kernel.org>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Tommaso Merciai
	<tommaso.merciai.xr@bp.renesas.com>
Subject: RE: [PATCH v5 6/9] pwm: rzg2l-gpt: Add prescale_mult variable to
 struct rzg2l_gpt_info
Thread-Topic: [PATCH v5 6/9] pwm: rzg2l-gpt: Add prescale_mult variable to
 struct rzg2l_gpt_info
Thread-Index: AQHc0LKQAfI+zbfS2Umvkb5WAcisQLXoOwPQ
Date: Mon, 20 Apr 2026 17:52:31 +0000
Message-ID:
 <TY3PR01MB11346EE50DBE9488A23735623862F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260420104332.153640-1-biju.das.jz@bp.renesas.com>
 <20260420104332.153640-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260420104332.153640-7-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB17044:EE_
x-ms-office365-filtering-correlation-id: 14f2db7c-8d92-479e-a04f-08de9f0598c4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 8WffkZWmSgz3ZjF+V838qL/5U8DFbiYL/Bd7eINLIkZRHDydVEE+oDLy21IVx7e6uEpMui75wHjfjmoNf+vnb7rGIIsIQBLpBdJj3ccYO2WedZy+9GHpLzLEyOt6GXk/MYNhVA6ZhMHUkTZih4FkZJEJOrpOl32puPe0rGmr8elps1Atpu4W6gCrUCS4ExeZMfn5ZOkyGbjnwPgP5ChSnKTzZWT1mqz9foIqlBg/oIPGRvVSuVTEJqjYbi3iitv3Me8ou4kA7Ab/cHrgcIfob9k35IlyleHpWstaep2Lp70Mc60M5d6E+8dQ9k0FJ8j5FcWPJkypauKSVGDJ47mnNkTGdYvKhrUoGjQyhdyz/xc95MAGmPQP6gqHwc2V785aWGmvORp2kk/Nvdq9r0n1B6OwGB+ye5JXhkXlt1OlaMy8ddjr5uBWEb53g4HjZkODMtUvrCJwJO7tKciAEcmGLwuhF1QfZ9COGOV0+NI+LKN5yYkhs6dv5Vc4cdp6cnPxjXTho+jicQdpSk9xsqZ8/KhuA1ocPMsy/RuiYqxOH9t25h56Hjm4sU3A0vpxHDePZA699bXA44MxifZdD72nGTcylsEVBiOU9BAfx5FKNC86/lyLUbb0lY46SYJ8F6Fzk59LulDjPOod+n3S/XTi+WRuFiUXIB521FzYqXbHXBjYNXdPGmMhbVNU3MRY970m8H1aF3kf3ln8oZjDuI5VGWETYpgVnWSirnCG8xA80rSkdMRS2UTJTUAL/yqF/i6bHYURnJJ717+xBrPVAg/T2/s6+PbksHDFlHPkE5EcR48=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+xiBe48Y1XCpEIMe6TACV9cNnvkP4TzMFJ252kBf04TNKUaCciSg8rjXw3?=
 =?iso-8859-1?Q?Gu0AQ7AKOfyCRDIOfSmJbEkrguPiO6U13XL+f9j3caignu6KSU8j8L8OfL?=
 =?iso-8859-1?Q?pMOaZDAAovbvHdumUgDKsT9yV/LomOz863VX+QqyI70li0xJgXn2DMFDyB?=
 =?iso-8859-1?Q?q8p4k7XnrwgzglR95cXbghdHKb3kDXRkDZexJY+hr8ndobd54+5s72cyLo?=
 =?iso-8859-1?Q?VOKXTqkkyGlyot4m5w0yoEsMI6RN1q4LtZJ1Ahf1Ea01kwZ/4iUJw6D/pf?=
 =?iso-8859-1?Q?4AvYiZqRMvz9aK1ox1GiE5fLrqCs/vsUT5UuHU6a5UlghXYFiqoGWsaoYg?=
 =?iso-8859-1?Q?jtisI28U8iB4THiamhEazkuPkeRN6BnSzJlAvySw1RFi7mUIDeF3NxmvGw?=
 =?iso-8859-1?Q?ReROCbPXScpe8/mOUvk5gzZZggtTA6YNJnq7JJyheeWZinkCszPOkIRQv+?=
 =?iso-8859-1?Q?2w8iNFdDkARx9yJwEqNcphdmmhhG5NjIyyCyMn/hVzqrUFiScW9rarcrwa?=
 =?iso-8859-1?Q?Qt61BPBCw4xFAFH7JYIu4RMsx6exSGa1k4lF3QShH1Nbm92U5yJt3asBe/?=
 =?iso-8859-1?Q?5F2JELI6hrSSaUL61zZmyO8HM0z6JSnozgYxRbxepaer/a7Muds0sQjNNl?=
 =?iso-8859-1?Q?kcoztDLcg0NdUxFWTQMbZcPKUEFT8pvUzgT2qp3+/vXhq67TNyos5rdbH+?=
 =?iso-8859-1?Q?GS+tUN8Ctxeu7f+Kn/KZdf+GzE8SCF2d18hs7xIxDwoJq5cgVrXeL2mkeL?=
 =?iso-8859-1?Q?F7UgWvTj372ZxBIjpIsbM+17mnAQsrnNhZqxDFCKjGBK9jmZjRlE3oc4Jf?=
 =?iso-8859-1?Q?MxkdqIaoK/eNnnPNOQJ6CkUbXlWU3DysHhKIqdSKpA0DzUrWNVL8e4b7u3?=
 =?iso-8859-1?Q?T/4eqHXW32Em1FSOpJoBN4rEUKzIqVXmarw1NtBm0XLVr0wPZ/pnD5j+Wx?=
 =?iso-8859-1?Q?yNkvM5MKElOhfw5EyIw4MkYvJRjRhnpxZ4oLetyyR+vOHFU/lSnaCySR4Z?=
 =?iso-8859-1?Q?xhPMk7Pel5necUjR5d8cyS3JtRhmxJswlu3PyLwyzA376n9ajgUiOcaybv?=
 =?iso-8859-1?Q?TTgk2O6Qz2l/hXbPggE7KT3xcxOryLyzkvvvlkMsCtI9lYV+XkIljZO7yG?=
 =?iso-8859-1?Q?V9931QQlYYRMI/VM+J5hsSZoG49i4u8MxeqweuPy6a7UHwzQiQZwvEXBRO?=
 =?iso-8859-1?Q?r1tm6M2Zc2Jd2DiHRoQiL6OkTeHRdBAAQ7+6TyZmsWblW7sFMW/Ha9BWjk?=
 =?iso-8859-1?Q?jmo/Ben5LcJmREKtgUkTKV5SALcIwvou4m9b80KIhe/F0DBLGgxGLvGica?=
 =?iso-8859-1?Q?7sJBIzzB5BHOMkX05subkOMatsyAsDJrf27Z2QKzW8FcyVlN+ShNnm9fEg?=
 =?iso-8859-1?Q?w1wHita3SNe7sSnb5BmuemZQYUXkwwkIWpBHpcT5WSrSn6OWXGIbCj0ISy?=
 =?iso-8859-1?Q?ZnGiNI2rK76TyV3LHiBOgg3pNTVTyWnEXQ5jBhhATF1xw3kRsZYQJyS9yZ?=
 =?iso-8859-1?Q?SVE1Vdt1oJ+EZn8Du40mzjlDcabgWvv3OF1p4evoMRfVm0Ker50Tdh7yAj?=
 =?iso-8859-1?Q?8iG0JUYSUek/9/ZwvvOMspRQ+hLtMGe3V5rYbmR8uW2fDISxgUYyViNi44?=
 =?iso-8859-1?Q?wdz/tvY8LdCBx/XS9IufYqKrhiiUUVa6DowCtVUAJABCbM0JkhPfP/lgl4?=
 =?iso-8859-1?Q?etDGl0gd8mE/XtnMPgf7eLa5yUGWUQGJ4CPT/xmFCGdS8ztfVAaZSJOvhi?=
 =?iso-8859-1?Q?7pdiHONWhH6sjh25Bt2tQWFurLA1LlO15t5jggMe86/DYAf+BOfyOrErut?=
 =?iso-8859-1?Q?XMFCKLGH3w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f2db7c-8d92-479e-a04f-08de9f0598c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 17:52:31.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpvrvqX2lcavZ35tCra2hhvrVOrui3AeCPe57UDMogc5EDY1kb5LvDXgTfudtimoAurFhUpFBbnw70riw0Acjia6ZGgvQbEeG/bBIpVaUXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17044
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8660-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,glider.be,bp.renesas.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 4B33E432C96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 20 April 2026 11:43
> Subject: [PATCH v5 6/9] pwm: rzg2l-gpt: Add prescale_mult variable to str=
uct rzg2l_gpt_info
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> RZ/G3E GPT IP has prescale factor power of 2 where as that of RZ/G2L is 4=
.
> Add prescale_mult variable to struct rzg2l_gpt_info for handling this dif=
ference.
>=20
> Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v4->v5:
>  * No change.
> v3->v4:
>  * Updated commit header and description
>  * Renamed prescale_pow_of_two_mult_factor->prescale_mult
> v2->v3:
>  * No change.
> v1->v2:
>  * Collected tag.
> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c in=
dex af594c1ce536..4324ffc8629d
> 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -92,6 +92,7 @@
>=20
>  struct rzg2l_gpt_info {
>  	u32 gtcr_tpcs;
> +	u8 prescale_mult;
>  };
>=20
>  struct rzg2l_gpt_chip {
> @@ -234,6 +235,7 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *=
rzg2l_gpt,  static u64
> rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
>  					      u32 val, u8 prescale)
>  {
> +	const struct rzg2l_gpt_info *info =3D rzg2l_gpt->info;
>  	u64 tmp;
>=20
>  	/*
> @@ -243,15 +245,18 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struc=
t rzg2l_gpt_chip *rzg2l_gpt,
>  	 *     < 2^32 * 2^10 * 2^20
>  	 *     =3D 2^62
>  	 */
> -	tmp =3D (u64)val << (2 * prescale);
> +	tmp =3D (u64)val << (info->prescale_mult * prescale);
>  	tmp *=3D USEC_PER_SEC;
>=20
>  	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);  }
>=20
> -static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 pre=
scale)
> +static u32 rzg2l_gpt_calculate_pv_or_dc(const struct rzg2l_gpt_info *inf=
o,
> +					u64 period_or_duty_cycle, u8 prescale)
>  {
> -	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * pr=
escale)),
> +	return min_t(u64,
> +		     DIV_ROUND_DOWN_ULL(period_or_duty_cycle,
> +					1 << (info->prescale_mult * prescale)),
>  		     U32_MAX);
>  }
>=20
> @@ -262,6 +267,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_c=
hip *chip,
>=20
>  {
>  	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	const struct rzg2l_gpt_info *info =3D rzg2l_gpt->info;
>  	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
>  	bool is_small_second_period =3D false;
>  	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> @@ -299,8 +305,8 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_c=
hip *chip,
>  		}
>  	}
>=20
> -	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks=
);

This is wrong here, as I dropped rzg2l_gpt in patch #3.


Cheers,
Biju

