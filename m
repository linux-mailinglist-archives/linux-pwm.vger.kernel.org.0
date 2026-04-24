Return-Path: <linux-pwm+bounces-8682-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMYTCQYy62lfJwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8682-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 11:04:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8798845BD71
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 11:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DFF43013695
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60731D366;
	Fri, 24 Apr 2026 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="I/kJD8c4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011065.outbound.protection.outlook.com [40.107.74.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754B361DCB;
	Fri, 24 Apr 2026 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021317; cv=fail; b=j/WpgsuX2KARshjWKjqTldNJq7P4mJGMX1FI4d2eQgF0Ycof0rQUWEwLZhjdUoE7KXiUUhp+IzhYGCDgg9gFfYcPo7lZUpz8abFV3LLaDysIGE4dm1wP2yf9EsdDMOkPDsFu5H6EnyU06vlKwel14VHsKRSO3v3hw9GtJWXq/2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021317; c=relaxed/simple;
	bh=XwO5R/j9Qbcn3pRqa6m1jplxMRQ2H8Nq+HwKs+4afXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WpQI1nfBG39Xsh2OkBR7gkl2PzE9zJmTRLrDAOnXeznID9foD/ZMfFZU9frEzOgsFpaO5o4BhEALNJgdsNdCfGxbbg1RAUAruOTZbgeLRHizb4wjL0lqQgWIIHerbt6Gzsr7cdboyrXsjQbs++I2Ja4n5+ntS5ZoVFBHWJVrNr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=I/kJD8c4; arc=fail smtp.client-ip=40.107.74.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEuczCWj6QtE4yStP4RNquyP9VxA4sjFwZm6ZdEoUQMEED1ZLGDXgNnTw10ZHxpdalL009BVUn72KeMQ3wcuGWUIaHyc54ztXO3iHs5AytpXEG5KuCQU3HslfEeYvUMJtLIonsOupnpN7g4an8ijBGG3USeCQ2ThMT0/2J1yqRjA2dV0T+RsBVyMJk0VA3Qx6RIkxSDA5NpWZAXvHn0TugFolHqVkXnPTIVvQqay/SqZJsTeZsAXNmtFzi2ua9b0eiWua6wu+JSypm01Kziy1fmILv3FtZ2PFaOpRm2Azx6JQdxoFtAt43AkJAwY2mEqBfHEh+BNEvqz6+8TnGcj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsyywVjNuJFaGyBQx8KCpbI8oCU6iwwtfOAQbgGiEFY=;
 b=VEYRt+03+3mS8nlF1f9yx4f/ckos7fs0cy+rW4h8fR5c9nRKTvwOpKBx7WyGDBoAUx1TCd6B3VgMxzErNhWt6/3t9vIJSWvaxRqZG64G+o2cWbx5ZEU4AkIHG3kIFOdqyEu5GTPBAq4mW6L9wFYk2lYQsK94MYI0tYwabep2JpFXUWUrks8iw5XCMWWkrGANfBqDsVr2/+LuEUpzgEBa8sBjbDycLAEIcqukWjWBmSOSqfL9q/z+7KcMN2YWrqlAgb/OOqrjaYb3B48xUQDThE+SAbExArknPeoe52pNWKoT5rWvh2RWop6hVvI/G3+LqriikzD9UpyCXotOynnFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsyywVjNuJFaGyBQx8KCpbI8oCU6iwwtfOAQbgGiEFY=;
 b=I/kJD8c4AOeCjWqhE7uyHK7fTMUBiuohNs7rma3FBIzGObHAtBgsOOR3DmocuprKEZqALEAO9Zbxchb5QYoQvPSbu64XCLp+TMk5Bf9Zw+HTrw0gWsTBW4LqdhUkhKPRnXRwY3vEYLoqHOAQtjTLi68ntKneSQdB7b0ELW+S5Bc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB15439.jpnprd01.prod.outlook.com (2603:1096:604:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 24 Apr
 2026 09:01:51 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:01:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
CC: biju.das.au <biju.das.au@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
Thread-Topic: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
Thread-Index: AQHc0LKQvlxtyV3slUeJAFuTBfcm3LXoPECAgAD3bICABLoNcA==
Date: Fri, 24 Apr 2026 09:01:51 +0000
Message-ID:
 <TY3PR01MB11346D2A5AD3D030E806594CF862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260420104332.153640-5-biju.das.jz@bp.renesas.com>
 <TYRPR01MB156193428AFA2FE631556EEDA852F2@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <aec2GeV_aP6rOtFg@monoceros>
In-Reply-To: <aec2GeV_aP6rOtFg@monoceros>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB15439:EE_
x-ms-office365-filtering-correlation-id: 728e0ce2-e904-45a4-2189-08dea1e0202c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 olRVsCPHRQ9KUV0UeQTKK9H2p847Ye6FWsc13+yBXz44mZ5P1AhkwFUrt7qcGvi2zqjiI3LZmXEO2aQUflkAOz3xTIXZGXxtonI+E9sSfHVa4cacZqLnMN75ggDPhd7F+CBUyWuVTapa8fjSfuvUGLfMqm3sdSIUZxGJoxBfjYQ5Np3HzIba3D5988OThszPCipTwyGAPWTV/7tcpuPmpZ33/DrwALq92VYnt8KaABA7E5SvuLploC1jTDPHnItwqZMJTkI9U3efOLk3IsohdEm4aGRvD0NywwRsGMnvL8IhSMJQ7vPzlcFIGCInHCtoMI1m5suYv9hEF9evwaBic4iGXb3VEkWFDiy6xFKQuHbPcU7hxzrTalvO24dOFuFI3C4uefPiY/qaCHiRNPeDCrbNdW1nvjpUluJbMLJkly++lYPw7aGaQnwrn8J2z+3ZRE1lyWZw5z8POxgu7eV46otdZPiEHcZ9BZgu5KwPZb1+1RoB8RqgSJBuWb6HYXUVT7xs8JoejCbT2ZhCA/grrUTcRCjkzjrvzIRoQAxTVhUVL6lelz2wkzoVuyDaYPQ5QOYB96l4POb+VASD0WIfT88TPC4I2wq6WZXVcFiJBJ5yXZrMQAicr2H9ynideJYjRdbLIqnkHumDMKFPO8bSSGYvZPUynyb7CAl3H4eugLCl31tdWek/iEccal+HI8bTJDHIj/jGrDX4oKBLo3sRzg45KmjFCYJYCYlEDVDaLPGn6+3HQ7iyXSVzeNOQZjUGQp9EYyf+k6gmdbfhxXrYqJekavUNYXEuLcONIrpw0F4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XmKU9ddATwZ9n8j2O/E6eGDwsNFoG9LhmoqyL4uenb6kZptiYrkXAlTnte?=
 =?iso-8859-1?Q?xDNAQJASirtRCsIDBaxdWXXNZFsYlnr85SJBr5RyTTVHSk9fC1w9RJo1bH?=
 =?iso-8859-1?Q?6YMTbcs2UiCT226YPLUGM9ywHnPFdOqbCX7S6NRrmvnXvDerbs9mdTzi8M?=
 =?iso-8859-1?Q?/NsV96B/3TquczjKW/WT1UP/w9W3oPv6CA653DzyeXJi2h0ucVmmuuroYv?=
 =?iso-8859-1?Q?LLtZfk9HT05H9AppIq+UUP3kRO00+iq2wXwJ7kso0cpM+E8dFPTRuR1X9P?=
 =?iso-8859-1?Q?tpNbDtQGyvQ8Mn2AudcLP1I7bFKd2kTIpnQr+mmL+K5hbWaWIWo3pltCf3?=
 =?iso-8859-1?Q?fYmTZwUjLvTrXnwiilsMFH0Pc+Q4R4j0jNKLVJHSXu/x0M/Chr76AOT+PQ?=
 =?iso-8859-1?Q?hA6KZ3gQQNipVmBH3rlfRBtsueRC04J+ati98CFrWKGIR5L2UeEH5QBI0h?=
 =?iso-8859-1?Q?u2ob/vbLuKi7oFIb/FIvtpmTLCIOsmCpgX/JI8Cawfy78JE9Qv/mNmV1Fk?=
 =?iso-8859-1?Q?MiYGpMtIW2AIDITJSRt8hZdDbUgRBHU8Y0sIBoFKCQuERLfBQoyTgbESK+?=
 =?iso-8859-1?Q?w7Yfa4vO0vckyRgcnEmKJa4wqy+IZyYBDQQwnKFmeygJUtBLEVG16WDN4M?=
 =?iso-8859-1?Q?lTM9IogdQos35kKCalvEejQgY/cYtSqPTfUirToC8HT52POgDI3v23Muuc?=
 =?iso-8859-1?Q?FZmjNjeQenbkFVoFIo4RYQX2ak0dkL3BhvLpVBysSJlDsJ2tczcMsawDsb?=
 =?iso-8859-1?Q?o+SwKJqI941vWGAAB2k0iRjCOFcoCIWqwo1886ebOQi0idzRiWb+GF11q/?=
 =?iso-8859-1?Q?qtNnPIOwb9E2fJDtHtji6wccfN1T17HArarVM6fmNU1mkKxE4tQb6A8ZsV?=
 =?iso-8859-1?Q?jUaXxK3yunl0CZE4tyOTH0nc6uwEvoKdd6+Os36BqyyB1NBJ6c1CVwyVRI?=
 =?iso-8859-1?Q?FxgucSczs9t2x7N4jx10ax2/eSJNL79L7o2OJs/LWEWrmfW/gSA6pbo/s/?=
 =?iso-8859-1?Q?CitxmKgBdMB3v3/z3NU4lx8ryzRswOytDaA25gZIEAMNW+JJ5tk2zj6GmT?=
 =?iso-8859-1?Q?NKhDhyrS9Od4OunacWfZE3+RMRFG+lulFOpxvtJtdTL9KGY9ZvzKGKAsEF?=
 =?iso-8859-1?Q?mjtWgP1NpP7fP6H71zzzdSw7DvIt0kNjJQYPiKl0addFhujOBkhKGvRimY?=
 =?iso-8859-1?Q?XL9WHtaVEMk9R1OShPDIuPFmhzsDi6jQijKR00GcONGR1Dk7QYaccV8eFL?=
 =?iso-8859-1?Q?RHGZ/7JwWjjXDCkUy4joTe80YY6k8CIBrD1ku6MbcW3fMWU6SzRG2JgJJJ?=
 =?iso-8859-1?Q?WhTUjuHS/rod90qZLNN3WvJOiaplQO7afEQKh6Vkoe+IbY9aSpg8rTA2lK?=
 =?iso-8859-1?Q?YoxakoMSoz6/AI9S/B1OdgeR3Gjup1lpCPip0l99EdJ1TqudOTZ61sAya9?=
 =?iso-8859-1?Q?ekOvn5rf5QoO1A/H8I+SG09cUSGpwS3V24ZMSaWzUrj3FL+aSyG5ks/cdJ?=
 =?iso-8859-1?Q?8zDbScq+lMy8U2OH+YP6dlXY2JBwjzhi1EAuZNP/JcY6b8LgxJgd8sELSE?=
 =?iso-8859-1?Q?7XDHI6LAVmHeEAfV5H/ntJLsKIrmw0+ewxQx/ODYqtnwXiVk3MqwOKLh1M?=
 =?iso-8859-1?Q?SKWIXbbRCfnSUH6vPSBsjIJo7oRoLJlVhFFg0593FSK0kuThYQHDyisN6Z?=
 =?iso-8859-1?Q?zXIShFlW0HXGfDJ003Wq4VXV3gUN1vnH4snPxuYd3eCn8GUWg/YX3wU6Rv?=
 =?iso-8859-1?Q?rksidBNU/pTl70A0A5sF+cXv9vImWoDPqr7D0L9frCghMaoYiq9HhflOb1?=
 =?iso-8859-1?Q?F9I83DesiQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 728e0ce2-e904-45a4-2189-08dea1e0202c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 09:01:51.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqqnuE0Wewgec4LaPxUv1vPXC00x3FZ3FVEn2x805xBunZHl6lkDIME8XG0yG75o16HRrnXeoxgd1YB4Nv+FUlAYyAyhuxrHYlFsmJov2dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15439
X-Rspamd-Queue-Id: 8798845BD71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,glider.be,bp.renesas.com];
	TAGGED_FROM(0.00)[bounces-8682-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:dkim,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]

Hi Uwe/Cosmin,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 21 April 2026 09:41
> Subject: Re: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
>=20
> Hello Cosmin,
>=20
> On Mon, Apr 20, 2026 at 05:55:07PM +0000, Cosmin-Gabriel Tanislav wrote:
> > > @@ -291,21 +286,26 @@ static int rzg2l_gpt_config(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > >  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
> > >  		u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
> > >
> > > -		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
> > > +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, NULL)) {
> > >  			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> > > -				return -EBUSY;
> > > +				is_small_second_period =3D true;
> > >
> > >  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
> > >  		}
> > >  	}
> > >
> > > -	prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> > > -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> > > +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> > > +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> > > +	wfhw->gtpr =3D pv;
> > > +	wfhw->gtccr =3D 0;
> > > +	if (is_small_second_period)
> > > +		return 1;
> > >
> > > -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->ra=
te_khz, USEC_PER_SEC);
> > > -	if (duty_ticks > period_ticks)
> > > -		duty_ticks =3D period_ticks;
> > > -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> > > +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->r=
ate_khz, USEC_PER_SEC);
> > > +	if (duty_ticks > RZG2L_MAX_TICKS)
> > > +		duty_ticks =3D RZG2L_MAX_TICKS;
> >
> > I know this change from > period_ticks to > RZG2L_MAX_TICKS has been
> > suggested by you, Uwe, but is this correct if period_ticks was set to
> > a smaller value in the earlier sibling channel condition?
>=20
> Indeed this is irritating. I assume I missed that and take the blame for =
the wrong suggestions.
> Depending on how hardware copes with such a configuration it might be ok =
to keep the code as is, but a
> comment would be justified in this case.

Please confirm

 /*
  * duty_ticks were clampled to match either period_ticks of this
  * channel or an active sibling channel's period_ticks.
  */
if (duty_ticks > period_ticks)
	duty_ticks =3D period_ticks;

>=20
> > >  	/*
> > >  	 * GPT counter is shared by multiple channels, we cache the period
> > > ticks @@ -314,6 +314,61 @@ static int rzg2l_gpt_config(struct pwm_chi=
p *chip, struct pwm_device
> *pwm,
> > >  	 */
> > >  	rzg2l_gpt->period_ticks[ch] =3D period_ticks;
> > >
> >
> > This should be part of rzg2l_gpt_write_waveform().

Also, if we move this to rzg2l_gpt_write_waveform() there is a rounding
error possible as we need to use hardware register to calculate
rzg2l_gpt->period_ticks[ch].

Can you please confirm, is it ok for you?


> >
> > Otherwise, if pwm_round_waveform_might_sleep() is called without
> > pwm_set_waveform_might_sleep() being called immediately after with the
> > rounded waveform, the software state will become out of sync with the
> > hardware state.
>=20
> Indeed, the tohw and fromhw callbacks must have no side effects.
> There isn't a set_waveform call after each round_waveform.

Ok.


Cheers,
Biju

