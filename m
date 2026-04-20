Return-Path: <linux-pwm+bounces-8661-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ4jAydp5mnBvwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8661-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 19:57:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75088432555
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 19:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBF713046F01
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00BC3A758E;
	Mon, 20 Apr 2026 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="EqouQclz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011058.outbound.protection.outlook.com [52.101.125.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD423A6F17;
	Mon, 20 Apr 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707716; cv=fail; b=UePLpYCtSilFQnwzDVS0XCy5jyIW8QmmSyWYHnx06rSzHCM2DcSkDgRDuVB3sCV8RElNZ4emcfCoNDJvzXfeZ6S9dmXUSV/+k29Kth645cjW7FXSpzYNXbVcEHNCCe+L5qKK7lPVfEieK4BNbILdpOLlGywDtNJwyYXI2v1aVTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707716; c=relaxed/simple;
	bh=u5HsDXI+2xn6ecsZWwS7EgID05QShYl7+yd1VSrQ3eM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p6xnfKGdL3DHFsCxg1s0qD79YM02cn+/g7DYx1teyuy7yeaBKZ39/WcCGHdiw49ttO/ULDACHkcCidbT1XhX3II4dUn54N0FA0Ne3Ycbt29EH8oRpvCRu9H8Jzd1OI+psERHFmEXZezh/ftaIL+NVgDsxo9C+udurv4IlyhEiIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=EqouQclz; arc=fail smtp.client-ip=52.101.125.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1E9DH6x81sD74qeQ0Olspp1EtkRS0cJx4DtZKKmC5rN1dHYljdHZZt61/xk2QsC7/Vv9R3NolVqt3sH49cYYUbn5fxJio5AUYVH7vPHGcGjeyX5uqla5lZ/ki3IvR9Rjv/F/k70MsO4ArN8RnLBfA17MeSOrpxAZMUzDajvUsP715aghdSBYJPQLOkSnTYOT7aouz7o1nQx/xp1P4MJts6uEIG7Y44QB5Ex6At0LgSh2M3t2w+zf+4RnEfONjKMhKuFy8o6U6bRy3ypsAYvqI+9RyaSyEONZiZcZLh9qWidD0bUueNki/40uMb3v62azPSeCA1MOPDB4SfpJpQzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2Ut5ROevr0T0PQBez9KulPRwmmLi81Pzcs1cD88KV4=;
 b=Aai2CoqUtK/ChslQdicFv7SWhiV988TCRawyPXmv390EFoQgsUl/UygvXss82+gSmSzDwOA/4c5Zm0RO3buYuGW1zQWv/nJv+kO2gYmBnHzgKfC9IApz418f10C+vOpEvDJhVK6ba57M9phrX5MsEXV2jiS0bDAQRj071ccUkH/AwErKahfxCQt/v3EmIA8v+WQq4vLVeMltc9H5mk8HecaIPZ96Jx4pK5RlWNSmljWCIgLr7ZO4q9vmP3nio5W+8p0sxjAA2BEuFFixTvZ+lm+o/JhXKc66WFF6zGlXg+DPJL/WgFXBmp2h0FleU0s4I7MzRJwhJRGEtxcygHEG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2Ut5ROevr0T0PQBez9KulPRwmmLi81Pzcs1cD88KV4=;
 b=EqouQclzAIWIXVgyo+7F/lGih18+mSuiCQPfUaKprsb4fN0TuzUPTaqZfcgYtQhnSblZy5H8zkB6boj/RBYMa1gQqJ40aX6ujRrRiYAV6Lw2RbwOW4MgD0RMEUtrAKkAJ9W7AjmAp3HZ4NkYVN52mWHV/Ok8zB6+wcYmqhrGin8=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TYYPR01MB13247.jpnprd01.prod.outlook.com
 (2603:1096:405:168::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 17:55:12 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 17:55:07 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
Thread-Topic: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
Thread-Index: AQHc0Ol9OJ14drQ/9EyWMLHIqRbl/7XoO88w
Date: Mon, 20 Apr 2026 17:55:07 +0000
Message-ID:
 <TYRPR01MB156193428AFA2FE631556EEDA852F2@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260420104332.153640-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260420104332.153640-5-biju.das.jz@bp.renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TYYPR01MB13247:EE_
x-ms-office365-filtering-correlation-id: 76db85d2-9d16-4c5e-0aa7-08de9f05f568
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 AcaOoVpb5m3GEQ25SMtdmZBl9FZtqRE+aDvkotTJgIsvPVumNLJhIs9L64wsSkQxkDx3m9kZ396o2YQmgX7TqcIzRsn39AN1zjD02/k5gnN7FMuNtiNiuXh9UnXabp4l3uaXQ1IuLfRVgbE3NBB0sVG+VxRWzAbVRzgXZ3VN6yMLvUjV/mAYdIfr+bxrVVFD+xd+TReedQ7ewTMWp6r5QuHeBWK8z2C77H69CjBb3jW9qzo0sCv/b6ytEAiWF/x1rVDE/MZsmc749zR1boQithdaIMyo9CB3hF1+8BfqLgbBoO4L4UQwI2yuexTAsYz6BivU6Yoe9UgAOvi7ggYb3T/RSbBADH3Nwv5fA/kEzVruQdpakM3sQYvSB4LWrDVwf6u5O2TMAAajWelzQZLzJLOm8t6VoCOC0zifKyxvBW3cnR8rcBM2DZY+czxlTm4l6c+CtdYs5BM+nObFssRrA59ALGkaMWaNOI1dEhNWZy6Lj6vPMwsN+oyktIn0hnPzCCoedvI3JW1PAUb1hJzrOufmRJ+XthNuUoLa+l3MA7u41lPnY6hM/tue30sraAz8XtCp3DsO8CsAQI1//8fqw96odmWSW4qrugePjdJzcjMvITxlqEhTFx8L0AS4Y73EENwK9uqEs9uoZ7RK2EH7giUMS9JlDUK4Ai4TyHDjFARmaUvW3DlnpnuoXsWsK1GeJIRvpTAdEzHS2Wmy05T5iGqPTRuthkIg7dBJyLIwMgea30GWkYOkl6cszDdbaH3b+ay5Yr5l/8mJZSVepbMcDp8AP/xysO9D0qg7urdT1aU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZIw9psunJT55OnLA+TocSV6AizameGjKSelFHSCUU51mcUfQiMGHv3CCof?=
 =?iso-8859-1?Q?M3bhcxPagJM1FxuCjwlv9xPhcPAtP8vea4GR5QB+4kbehkzsrNkJwmI7+b?=
 =?iso-8859-1?Q?xV2jomFx8hsshdBLzPWUZxpvLBLNOx2vDf3qJORPtY8Si+RQE7AyYZ1mws?=
 =?iso-8859-1?Q?TXqf2DVFmj4JLz1QlNBBBEjEf9UpVuPh/5LJTo9c8g4bsbJ22WzstN/45F?=
 =?iso-8859-1?Q?0jvvz1JBtadDMbRufTp/IK2Uw267zBg3RfGtgTN0DLqoZkhZk5oiSY+S9X?=
 =?iso-8859-1?Q?MYobJnQkQCgvv4NB+GEu++jupl/cdUMW/ouItkz8f9D7qYXVndJ0+ssRjk?=
 =?iso-8859-1?Q?2HwZNTZwtrvlSlUCjhX5GMUKhRQxsIZ7MYkrrINIqpRCV5dmsW2ua8pxTn?=
 =?iso-8859-1?Q?BZriBiWMQD/ASkMjISkeYw4NwHAsKmU+tj4PmgxE+ukcwcmR4xlAMJ0Rr6?=
 =?iso-8859-1?Q?BHGOIDOG+kyMhs9q2H1ic0WQJuSt6Nz51EbinbJFKpfviBGtg20vRMlVDG?=
 =?iso-8859-1?Q?+RWXDbY/6Z2E/S295VJ8yUvg6mBBr1gPoaj8RaYtk4c7CJQkjwWq+K82+G?=
 =?iso-8859-1?Q?rmzmPEEwJzVYDwnnWZiV2O/dftOtW1pUy9CdX7Bpnwj+V6udqnTmk9RwMV?=
 =?iso-8859-1?Q?oAfASKhqKU7mLIJxdwe57ZGDd4Bfr3CnlObyCLZ1S3J41cN4Py1oDhhfwh?=
 =?iso-8859-1?Q?XtekwzyEJ6hM9h8n3lzRS6HJzol3ARmFJfA88xBD+omBI+Z4WFEcr6jPWk?=
 =?iso-8859-1?Q?kLI78f6xxwF8x4eqdI0orFREgmZ2b3moUNJ3Se2aDsWlQ2+exCOW0AqLZe?=
 =?iso-8859-1?Q?Ay0YloGCGqe/f+YwU2QGRr4AcjBNS7fwWB7SRL7sA/gXE/MIMNUNtaSnTy?=
 =?iso-8859-1?Q?TVWFsn8O8oltaHwJlXx1dWyk+ivIOBguM2P2MUC5p7/DWrDdfEdWnyovBZ?=
 =?iso-8859-1?Q?1L33GXTvuVRdI1pGhkz+tt+C+TWPWwx862HhQWxfpQQm9MwT6+2gDVJ8q5?=
 =?iso-8859-1?Q?STjMv+rtjfCIJUmXox0D4WVw7kunT1g9+19GYxGRTOuf4tvA9/ocl+rXXa?=
 =?iso-8859-1?Q?mErtVGFgPEbZJaj1AlHgoPmh0wZA2Ru5SKC9/6+G61D9wbl/IJZr+YOSgb?=
 =?iso-8859-1?Q?2HnkU3hqqxLizDCDGhxWcwyG9rOidD49yMy9ivPCDjfQLN+ZnuawlyTK0d?=
 =?iso-8859-1?Q?Nb+C3DRsROx3zRU8AbaMN6oPx6wWO69x1hrv9fc4Mj2rPKSUKz0mJW9RWs?=
 =?iso-8859-1?Q?A+fAbHZ5wHze3LOH3IAgj6ziJz2Cz0w9rzRup1PYqAlIBp3qKgq1Rs89jM?=
 =?iso-8859-1?Q?Kpdc+Y77YwbH5fzcCSzpRQ4m25tzfDLfyMa5o9JClC2m6R3d76QL1aSxzc?=
 =?iso-8859-1?Q?tRW27ZAYC+BO8SON4qSNnqu7RAB6Cd7upFQ2qcoiB+OT+/VpqX27DGlkiB?=
 =?iso-8859-1?Q?zCStVMFuVhR1ytXVjSXHzI1HxYRscSY9M3FeryzAqV/WT/7r5MIdBNARgH?=
 =?iso-8859-1?Q?XE0fuxvtTc2f1qKgHSr/QKaB1sosvJ4MXfO6/IZldDfNCzbz5VrkETDRfM?=
 =?iso-8859-1?Q?FpPkxLXvJ8EMEOu27yEt9Ki3KVKJCNXxCvrOL9d3rk9zl+WitzulNruDQF?=
 =?iso-8859-1?Q?FOp9gcQkQ+IUp/woZQSCTWhh3pF9Nc/K2auTzk+bBzgcB1JJRrJj24xq0f?=
 =?iso-8859-1?Q?Z0lXnuT0WHu2Uk7XMt7ZaCVRYT1KVjFSFyVNYSGCLrjTpZnHMTHIBI7K78?=
 =?iso-8859-1?Q?K2e2kEfq6m6yCtcDk8TPd51M7bixK9o+dFBae4935Umaljz2pYKDQQLUKf?=
 =?iso-8859-1?Q?RsoHq/Hy5IK99gq0lNAB9ju3mCNAjUbfHEMmZr4SS6Pac85CyBBC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76db85d2-9d16-4c5e-0aa7-08de9f05f568
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 17:55:07.3736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0AqZbbd/x3memQrd7a7VOUQUkhe/76YRYCm33nJ1ln/QfZr8dgNZjQZFYTOdTUOe+Dpkd917fFOn22k1eYo4YtWW+3oa4wmLzVp2Qjsc7Pi22zcltwGyfVHHistFOCg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13247
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8661-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[renesas.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:dkim,renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,glider.be:email]
X-Rspamd-Queue-Id: 75088432555
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Biju
> Sent: Monday, April 20, 2026 1:43 PM
> To: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; linux-pwm@vger.kernel.org; lin=
ux-kernel@vger.kernel.org;
> Geert Uytterhoeven <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prab=
hakar.mahadev-
> lad.rj@bp.renesas.com>; Biju Das <biju.das.au@gmail.com>; linux-renesas-s=
oc@vger.kernel.org
> Subject: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Migrate the rzg2l-gpt driver from the legacy .get_state/.apply ops to the
> new waveform callback interface.
>=20
> Introduce struct rzg2l_gpt_waveform to represent a hardware waveform
> configuration holding the period register value (gtpr), compare/capture
> register value (gtccr), and prescaler (prescale).
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v5:
>  * Updated commit description.
>  * Updated rzg2l_gpt_round_waveform_tohw() to initialize gtccr when the
>    period of the second channel is smaller.
>  * Replaced period_ticks with RZG2L_MAX_TICKS for the duty_ticks maximum
>    value check in rzg2l_gpt_round_waveform_tohw().
> v4 from [1]
> [1] https://lore.kernel.org/all/20251208152133.269316-3-biju.das.jz@bp.re=
nesas.com/
> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 197 ++++++++++++++++++++++--------------
>  1 file changed, 121 insertions(+), 76 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index 659044fa3d2f..9e7a897a0b4d 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -100,6 +100,13 @@ struct rzg2l_gpt_chip {
>  	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHAN=
NELS);
>  };
>=20
> +/* This represents a hardware configuration for one channel */
> +struct rzg2l_gpt_waveform {
> +	u32 gtpr;
> +	u32 gtccr;
> +	u8 prescale;
> +};
> +
>  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *=
chip)
>  {
>  	return pwmchip_get_drvdata(chip);
> @@ -166,7 +173,8 @@ static void rzg2l_gpt_free(struct pwm_chip *chip, str=
uct pwm_device *pwm)
>  	rzg2l_gpt->channel_request_count[ch]--;
>  }
>=20
> -static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8=
 hwpwm)
> +static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8=
 hwpwm,
> +				    u32 *gtcr)
>  {
>  	u8 ch =3D RZG2L_GET_CH(hwpwm);
>  	u32 val;
> @@ -175,6 +183,9 @@ static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_=
chip *rzg2l_gpt, u8 hwpwm)
>  	if (!(val & RZG2L_GTCR_CST))
>  		return false;
>=20
> +	if (gtcr)
> +		*gtcr =3D val;
> +
>  	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTIOR(ch));
>=20
>  	return val & RZG2L_GTIOR_OxE(rzg2l_gpt_subchannel(hwpwm));
> @@ -233,54 +244,38 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struc=
t rzg2l_gpt_chip *rzg2l_gpt,
>  	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
>  }
>=20
> -static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> -			       struct pwm_state *state)
> -{
> -	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> -
> -	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> -	if (state->enabled) {
> -		u32 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> -		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> -		u8 prescale;
> -		u32 val;
> -
> -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
> -		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> -
> -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
> -		state->period =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, val, p=
rescale);
> -
> -		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
> -		state->duty_cycle =3D rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, va=
l, prescale);
> -		if (state->duty_cycle > state->period)
> -			state->duty_cycle =3D state->period;
> -	}
> -
> -	state->polarity =3D PWM_POLARITY_NORMAL;
> -
> -	return 0;
> -}
> -
>  static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 pre=
scale)
>  {
>  	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * pr=
escale)),
>  		     U32_MAX);
>  }
>=20
> -/* Caller holds the lock while calling rzg2l_gpt_config() */
> -static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> -			    const struct pwm_state *state)
> +static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const struct pwm_waveform *wf,
> +					 void *_wfhw)
> +
>  {
>  	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> -	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> +	bool is_small_second_period =3D false;
>  	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
>  	u64 period_ticks, duty_ticks;
>  	unsigned long pv, dc;
> -	u8 prescale;
> +
> +	guard(mutex)(&rzg2l_gpt->lock);
> +	if (wf->period_length_ns =3D=3D 0) {
> +		*wfhw =3D (struct rzg2l_gpt_waveform){
> +			.gtpr =3D 0,
> +			.gtccr =3D 0,
> +			.prescale =3D 0,
> +		};
> +
> +		return 0;
> +	}
>=20
>  	/* Limit period/duty cycle to max value supported by the HW */
> -	period_ticks =3D mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_khz=
, USEC_PER_SEC);
> +	period_ticks =3D mul_u64_u64_div_u64(wf->period_length_ns, rzg2l_gpt->r=
ate_khz, USEC_PER_SEC);
>  	if (period_ticks > RZG2L_MAX_TICKS)
>  		period_ticks =3D RZG2L_MAX_TICKS;
>  	/*
> @@ -291,21 +286,26 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
>  		u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
>=20
> -		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, NULL)) {
>  			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> -				return -EBUSY;
> +				is_small_second_period =3D true;
>=20
>  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
>  		}
>  	}
>=20
> -	prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> +	wfhw->gtpr =3D pv;
> +	wfhw->gtccr =3D 0;
> +	if (is_small_second_period)
> +		return 1;
>=20
> -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_k=
hz, USEC_PER_SEC);
> -	if (duty_ticks > period_ticks)
> -		duty_ticks =3D period_ticks;
> -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_=
khz, USEC_PER_SEC);
> +	if (duty_ticks > RZG2L_MAX_TICKS)
> +		duty_ticks =3D RZG2L_MAX_TICKS;

I know this change from > period_ticks to > RZG2L_MAX_TICKS has been
suggested by you, Uwe, but is this correct if period_ticks was set to a
smaller value in the earlier sibling channel condition?

In that case I think it might be possible for duty_ticks to end up
larger than period_ticks which wouldn't work correctly with the
> RZG2L_MAX_TICKS check, but would have been clamped fine using the
other check.

What do you think?

> +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
> +	wfhw->gtccr =3D dc;

Is there any reason why the results of rzg2l_gpt_calculate_pv_or_dc()
cannot be assigned to wfhw->gtpr and wfhw->gtccr directly?

That would get rid of the pv and dc variables as we do not need them
for anything else anymore, as far as I can tell.

>=20
>  	/*
>  	 * GPT counter is shared by multiple channels, we cache the period tick=
s
> @@ -314,6 +314,61 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	 */
>  	rzg2l_gpt->period_ticks[ch] =3D period_ticks;
>=20

This should be part of rzg2l_gpt_write_waveform().

Otherwise, if pwm_round_waveform_might_sleep() is called without=20
pwm_set_waveform_might_sleep() being called immediately after with the
rounded waveform, the software state will become out of sync with the
hardware state.

Uwe, what's your take on this?

> +	return 0;
> +}
> +


