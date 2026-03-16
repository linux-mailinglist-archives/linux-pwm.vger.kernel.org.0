Return-Path: <linux-pwm+bounces-8277-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKFgOT4nuGnhZgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8277-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:52:30 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 679A029CC74
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26D0C303E3A7
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239983ACA65;
	Mon, 16 Mar 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="VJqvQjp/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011064.outbound.protection.outlook.com [52.101.125.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331E3AA197;
	Mon, 16 Mar 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676201; cv=fail; b=mrfup3AFshH0wdLzzglVseVesIFaYMU2YvXHaR2u2XcnKf+SoPq+Gay83uRd9m2Dn9+pbcbXmWHrnTAx4ffSIitnykS1RyrdAcDdpM+lLbLfc5uM3zHGNEiFHE/djok0zHBMAKKPbb9FqBjfGc/TVncJ3kN6qGMWpK3reNOT2r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676201; c=relaxed/simple;
	bh=fn3DsrC94y3k3XBc727gR8YWeMV/zDkWnYU0QV3Mm+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=at3R7Z4h9BM3bGAYypG+19rLeavEqD5gvPZ+dlSz3QeAnrawG6ZqT25MB3T87X15JRX8jMWVIPuElAC5MQlQjInttis+QBZxQlXk7ytZOT+gu3m7/Dk9fmtb9DDaXVRWRbccEkr4pXG1TmKwYEBqQ9yW89zrnXoAIu0qizT03PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=VJqvQjp/; arc=fail smtp.client-ip=52.101.125.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdxn1QDzsFnNvpWW24EDgvhRkDLM8IL27FiSyc8weAfbdRYGZOwfLdh7foJ2i/P6He7deEreoU7l8SVeCxBmOKwxlzJmfV4ps+3gHtF/JPBnxD2mgg6/hFDtGHkuodmHhWMws5zWoWM5GLqClxxY3wFUqqF7QvegM4+9Jo1Ve6RuwGyu6ChiO6xxyj8bfStAw+lTWmZZzXTGcP7NyAub/W2PLhlybcbAs/oAi2+pc4kuWgidKnb2Lpvi6y5dBNxRRv+NrXbFpFc1GUbb3vfzounBHge70ztyLrfOQPI2N9DDH+wx+L91LMF1/1qKYp51B0up7PscQ71mpZezo3vXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqWE9lTo93pZJ729jFbwqq/NOwlwPfJNsp0YR+u9S9M=;
 b=J8AatYDWv/Fn0VSIw12S0c+RNuqk2P+c6fjxwc2ebr1S9YedPtW8BsgmxmMnyEUQPUz0z222n0bJz7OwF2SDuBhe7W4mngUcK2nTnIP1IpavPECU7o1AqPpixbJ1WBk1eyQarOFLcl6QPVfTMwRMR1ev4H274MCctDZAUsUl10PP7YUOHBMbMbGXTWmhayHcCEKj6uAKsJW31lM9m3jpbrEFh/bV6Gq6eiXtNcwEnm+h63q0Q7jwZzLVREzZJeHLgKt87F5tgwZDijyKMm1nQXCqQu3h/Hvcxpw+o39QrRJrEH1l+VhEYAYj+b3YLpVkjxTrW+wOdpUztShYDrLelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqWE9lTo93pZJ729jFbwqq/NOwlwPfJNsp0YR+u9S9M=;
 b=VJqvQjp/pJJ8Dc9WeMnde77oS6XAOy+bXWSqFQw4Ce8FYFoOGH9lMnOIUEEsUURPHPhXjKDEoUlUYS7nAdnwVTdquHI0y6aPVGizmjdxl3AAs5HQXs91iuT3iG0rp+15pJu5uRm1H43AtlfOHL4IOPx+ekSqi1gYZ0lHg3JPwac=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by OSZPR01MB9393.jpnprd01.prod.outlook.com
 (2603:1096:604:1d9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 15:49:39 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 15:49:35 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
CC: William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Thread-Topic: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Thread-Index: AQHckeNxm+l5nvVDhECE0kd9r0GiYLWhc7cAgAAuuBCAD+SBUA==
Date: Mon, 16 Mar 2026 15:49:35 +0000
Message-ID:
 <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros>
 <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|OSZPR01MB9393:EE_
x-ms-office365-filtering-correlation-id: c0c1ec11-abf3-4fc0-7216-08de83739fc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 39NtqeBfNLN9OkuK3ht3IUfS/CGbrwpxCe0Alc24ixMTKJHODmy1piJe5JLkzpqw2hMhuX8wVGIz3ANjZFzhJeSpnR0L8Y/iY6CqHp5jGrjraBe5iKcooW0ulp0XESpGaUU4USbPtR+UdA9yIEbsmX9GzextmeGoxEBtw/sSK1J+CAQF78A91XrxcnNRQ2LGyzPW1oUDiXG+eI3jQXX6jPYquHBqNigLvU52eXjy8tmpv/h1zTL6wf6qDbFehaj/8wsxRPn8Scqfyoxc8IyWiZnEtGkZ6F3xt2WOhOirirOWLsWxVHHPqhOS+xvZOmB3PIxCXnixwIbcK3S4mD9Oh1GB74InAF4lGsnqnzzKreWTUffuKJ3wcZ197lRPwhn44Pp3fowg8QH0obhxvw6BnQECswtpmpgLCzGoLS7KHoS7E65PcfDKi1Mz1hXiWik4C9DDJyvlwN13PamMoSl5IDo6KppL6RkpWpLTUoBJxoLvzpVo5btYPiCJTkTU8vipZN3sSXMW289qO/n5ub1iGDJ+FHaULQkJLs6sVAepx8LGWjpQ4Tmo/Me19lyyIFKs/km8MLu0Ha7c8fd42fhmsFdAGxe2VMwFXDaWAdbAzM3+BK/ZlGJj67ZsBZ/sf31RcXchpJuU1oLMZrqQCxHjHscR8B3zSX8HoSGeDZNDHPfmssQvCRDvLg0MuU7TNkb0A9SzFz1wq6sN09MNgtwp6jYfbOk1fyLEDBiTztYQDuTtMa0hNSL0jwAxQ2Xkb7eJRC8e0NgRDJbRYOhWgbqXKNBW6uhHnzqdA6d/kPHw1eg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?APoB1VQGLiw2hc3kLkb70PQOZ42dz0Jp9Sy6FF/O5m6fJEYaTUEa7lRtWQ?=
 =?iso-8859-1?Q?dlYShU0RfYgeKAxPkb7fpAjXKA7qpq3ICtAbmIG2o7eNl+xb2zdkK3gQ8Q?=
 =?iso-8859-1?Q?aaszyStl/F00zxWwyoAV/e8No58Yjsopcac7Xfm3DK1S6mJg0w91mVlO5a?=
 =?iso-8859-1?Q?4QpvRALc/Q+6pZhlPleu81y02zU+KEK1gHxUBDWHan87rGO5ttS+PuTD3x?=
 =?iso-8859-1?Q?ahyaYSbm3jqXVN6F8W/xW1bVTh5sxfU8gJfhiV5xRjfG1kaKrdsnl6zCwH?=
 =?iso-8859-1?Q?GrsVnyU6oUw7P/Wt3Xi6RgQkc679Y8AhsagkhR22u5byEQKlsK9BcXbVUC?=
 =?iso-8859-1?Q?L8SxAPQDygthGWRXoKGiUt31RKVSXMeP4cEKWvUJN1E986jHYCo/xLsUSi?=
 =?iso-8859-1?Q?aFTG9UTJJfXvDlSa0kEUR/w+p4v/HwDkPf3ldRMoPxRLuyUOLVLo3al6sX?=
 =?iso-8859-1?Q?my5e5Jyjp26w6u1pi/53pYAEX1TXb1+DB+EgA7BYOLha/qvj3JJwuHy2eW?=
 =?iso-8859-1?Q?Wo66ABMgxhyYs+HEe6kJtFXJP7wrqBQ7zlWUm/HBpZ00IQRXvM6Q8lFOJZ?=
 =?iso-8859-1?Q?+522w1yL4YJpyRJ1xrdupQJ2nMT+SErgRy69EUHw+0BI2fbm14ZvO8IVsp?=
 =?iso-8859-1?Q?Oy3xIkOYmz3+w9jJQQq5lGj2ptljDXJ2pCNPktOuhpmIc2NYtibsMnGsaC?=
 =?iso-8859-1?Q?75iTGLon1MB49FEFVvM3GC6EnaEM4Y0bFEq1swt1+EBcEWH1JWRFI8OSav?=
 =?iso-8859-1?Q?YJmjv8Rht0QNeXsKGB2loVXbv7mtEReDvK3kO12tSC7H1HJOW7I1eyN6GL?=
 =?iso-8859-1?Q?BM5AW+MKuNPmXXx2SZJKn43V7aazg9GO1KnM8I3merkGsq2N6ycknR60HT?=
 =?iso-8859-1?Q?VGrJ+PIQ1afi41eIKhb26UGQ9xMQbCduYLlnuMTlgnMkwC732qF2wmKg6J?=
 =?iso-8859-1?Q?zgokrgwr2Z9LkYu1xfbC5LugxmEnGFDOWSleaJwSBzCfRCAhPCKT4JCZNp?=
 =?iso-8859-1?Q?KR7mZHp55S80yoV6m0tsl9w4S8FA/cwaDeTgnV6YVKTa4Sz0ohkgRN5ds/?=
 =?iso-8859-1?Q?qz4w2y+wEh20R1RTPoFhG1TX8lfF10NyULjPKUf6v2lH8IkqzV005avq1T?=
 =?iso-8859-1?Q?3+jsjYdDUEq5e4Vf+3mUiL+keR461GlG3XPgFGZI+0wJP2PRtCzNA+Sg7K?=
 =?iso-8859-1?Q?x7v24PGenZg9CBAnIhCGDcO3qCyphNVv9DYGyi523Ypgg1ZmmTMJuCojGK?=
 =?iso-8859-1?Q?OyHgJt0sC4zHC+Ka4SchJt0fInUKp1/AJ4a9jvGPyKfuMp5JhUnvzGt7+T?=
 =?iso-8859-1?Q?7hW+gLGfp4nqC9zTqiVEtp5fBjKMgowSetBAX6xX15JQTJdpAAaocAeZMA?=
 =?iso-8859-1?Q?KUuc+UA7HVoWC97OigjZuu1hw03JCo3hHe3OnSM1Ba2YdW6NWYZQV1aj0x?=
 =?iso-8859-1?Q?yfcF0cCTB+HLw3kUnGEBpNntSLM20AFBT+zJOJYmGRga+pf7Rr69mMQytC?=
 =?iso-8859-1?Q?7TCJ/f8rLRKJyXcEhSo6lGao2cxV0WIcokYnVKEBrIphImsSHv6wcKUiSk?=
 =?iso-8859-1?Q?2X457aP5aRSh/8XouShUIPeQYZrOuVpI1pLCTV12NLfqPq6F3htwATXMQE?=
 =?iso-8859-1?Q?VvHkuQ8RCUQL+kF5x948WmMUy2bLUlPoj0mdEmr4zXccnXAIU6HTJ1QNpM?=
 =?iso-8859-1?Q?fh+25CuhCeGu0GAlOGU8CikDnIvjBokXkKyZeW6zPJlSIHaEapPqxH6o7f?=
 =?iso-8859-1?Q?QkPQ+RLNps30yZfni0PmYjtJrsCm1dS1co2jLaJCM/ITwf7eHjL7ThvnPm?=
 =?iso-8859-1?Q?nHzbDdFAXghQCUu0cFk9d9DKgtk9Lr9/88xRMQF55e8+uxj4Hj2h?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c1ec11-abf3-4fc0-7216-08de83739fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 15:49:35.7854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVUhV8eP9d2IjV1lsuekuLayJe+jHD64H+8q/FTOfZRumIC3YtNApFazaDkcw1zdHO7jpMxan5foSQURS6na71Sw96m91Hz5sC3aJpHGsXxuGeAuCgp7pANYDqAK7WW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9393
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8277-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[renesas.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:dkim,renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,TYRPR01MB15619.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 679A029CC74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Cosmin-Gabriel Tanislav
> Sent: Friday, March 6, 2026 3:27 PM
>=20
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > Sent: Friday, March 6, 2026 11:30 AM
> >
> > Hello,
> >
> > On Fri, Jan 30, 2026 at 02:23:49PM +0200, Cosmin Tanislav wrote:
> > > enable_count is only incremented after rz_mtu3_pwm_config() is called
> > > for the current PWM channel, causing prescale to not be checked if on=
e
> > > PWM channel is enabled and we're enabling the second PWM channel of t=
he
> > > same HW channel.
> > >
> > > To handle this edge case, if the user_count of the HW channel is larg=
er
> > > than 1 and the sibling PWM channel is enabled, check that the new
> > > prescale is not smaller than the sibling's prescale.
> > >
> > > If the new prescale is larger than the sibling's prescale, use the
> > > sibling's prescale.
> > >
> > > The user_count check is ensures that we are indeed dealing with a HW
> > > channel that has two IOs.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.co=
m>
> > > ---
> > >  drivers/pwm/pwm-rz-mtu3.c | 24 +++++++++++++++++++-----
> > >  1 file changed, 19 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
> > > index ab39bd37edaf..f6073be1c2f8 100644
> > > --- a/drivers/pwm/pwm-rz-mtu3.c
> > > +++ b/drivers/pwm/pwm-rz-mtu3.c
> > > @@ -142,6 +142,14 @@ rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_=
mtu3_pwm, u32 hwpwm)
> > >  	return priv;
> > >  }
> > >
> > > +static u32 rz_mtu3_sibling_hwpwm(u32 hwpwm, bool is_primary)
> > > +{
> > > +	if (is_primary)
> > > +		return hwpwm + 1;
> > > +	else
> > > +		return hwpwm - 1;
> > > +}
> >
> > Can we please make this function a bit more sophisticated to not need
> > is_primary? Something like:
> >
> > static u32 rz_mtu3_sibling_hwpwm(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, =
u32 hwpwm)
> > {
> > 	struct rz_mtu3_pwm_channel *priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, =
hwpwm);
> >
> > 	BUG_ON(priv->map->num_channel_ios !=3D 2);
> >
> > 	if (priv->map->base_pwm_number =3D=3D hwpwm)
> > 		return hwpwm + 1;
> > 	else
> > 		return hwpwm - 1;
> > }
> >
> > (Or if you want to save the rz_mtu3_get_channel() call, pass priv to
> > rz_mtu3_sibling_hwpwm() which is already available at the call sites.)
> >
> > And well, BUG_ON isn't very loved, so either it should be dropped or th=
e
> > issue escalated in a more civilized manner. I keep it for the sake of
> > simplicity during the discussion.
> >
>=20
> I can do that. And, to avoid having the BUG_ON(), we can make it return
> an int and receive a sibling_hwpwm pointer as an output parameter.
>=20
> With that in mind, this patch could be simplified to the following diff
> (approximatively, I haven't tested it yet).
>=20
> Please let me know what you think the best solution would be.
>=20
> diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
> index ab39bd37edaf..4548af0c3b3c 100644
> --- a/drivers/pwm/pwm-rz-mtu3.c
> +++ b/drivers/pwm/pwm-rz-mtu3.c
> @@ -142,6 +142,20 @@ rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3=
_pwm, u32 hwpwm)
>  	return priv;
>  }
>=20
> +static int rz_mtu3_sibling_hwpwm(struct rz_mtu3_pwm_channel *priv, u32 h=
wpwm,
> +				 u32 *sibling_hwpwm)
> +{
> +	if (priv->map->num_channel_ios !=3D 2)
> +		return -EINVAL;
> +
> +	if (priv->map->base_pwm_number =3D=3D hwpwm)
> +		*sibling_hwpwm =3D hwpwm + 1;
> +	else
> +		*sibling_hwpwm =3D hwpwm - 1;
> +
> +	return 0;
> +}
> +
>  static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_p=
wm,
>  				      u32 hwpwm)
>  {
> @@ -321,6 +335,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
>  	struct rz_mtu3_pwm_channel *priv;
>  	u64 period_cycles;
> +	u32 sibling_hwpwm;
>  	u64 duty_cycles;
>  	u8 prescale;
>  	u16 pv, dc;
> @@ -340,7 +355,9 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	 * different settings. Modify prescalar if other PWM is off or handle
>  	 * it, if current prescale value is less than the one we want to set.
>  	 */
> -	if (rz_mtu3_pwm->enable_count[ch] > 1) {
> +	if (rz_mtu3_pwm->user_count[ch] > 1 &&
> +	    !rz_mtu3_sibling_hwpwm(priv, pwm->hwpwm, &sibling_hwpwm) &&
> +	    rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, sibling_hwpwm)) {
>  		if (rz_mtu3_pwm->prescale[ch] > prescale)
>  			return -EBUSY;
>=20
>=20
> > > +
> > >  static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mt=
u3_pwm,
> > >  				      u32 hwpwm)
> > >  {
> > > @@ -322,6 +330,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > >  	struct rz_mtu3_pwm_channel *priv;
> > >  	u64 period_cycles;
> > >  	u64 duty_cycles;
> > > +	bool is_primary;
> > >  	u8 prescale;
> > >  	u16 pv, dc;
> > >  	u8 val;
> > > @@ -329,6 +338,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > >
> > >  	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> > >  	ch =3D priv - rz_mtu3_pwm->channel_data;
> > > +	is_primary =3D priv->map->base_pwm_number =3D=3D pwm->hwpwm;
> > >
> > >  	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> > >  					NSEC_PER_SEC);
> > > @@ -340,11 +350,15 @@ static int rz_mtu3_pwm_config(struct pwm_chip *=
chip, struct pwm_device *pwm,
> > >  	 * different settings. Modify prescalar if other PWM is off or hand=
le
> > >  	 * it, if current prescale value is less than the one we want to se=
t.
> > >  	 */
> > > -	if (rz_mtu3_pwm->enable_count[ch] > 1) {
> > > -		if (rz_mtu3_pwm->prescale[ch] > prescale)
> > > -			return -EBUSY;
> >
> > OK, I understood the issue. If the sibling is already on and the curren=
t
> > IO is still off, enable_count doesn't account yet for the current
> > IO and thus is 1 but still the prescaler must not be changed.
> >
> > The commit log needs updating to make this clearer.
> >
>=20
> I'll try to rephrase it to make it clearer.
>=20
> > An alternative would be to check for
> >
> > 	if (rz_mtu3_pwm->enable_count[ch] + (pwm->state.enabled ? 0 : 1) > 1)
> >
> > but I'm not sure this is better.
> >
>=20
> This was essentially my initial solution internally, but it was argued by
> my colleagues that it would be difficult to understand.
>=20
> The solution that I ended up submitting here is more explicit and easier
> to grasp at a glance, at the expense of being lengthier.
>=20
> I still quite prefer the shorter solution, as it is not necessary to quer=
y
> the actual hardware state in this scenario, as the PWM state should alway=
s
> be in sync with it.
>=20
> The PWM state is enough to figure out the effective enable_count, as we c=
an
> only make it into this function when
> a) the PWM channel is already enabled and it is being updated OR
> b) when the PWM channel is being enabled (and it was previously disabled)=
.
>=20
> > > +	if (rz_mtu3_pwm->user_count[ch] > 1) {
> > > +		u32 sibling_hwpwm =3D rz_mtu3_sibling_hwpwm(pwm->hwpwm, is_primary=
);
> >
> > Maybe add a comment here saying something like:
> >
> > 	Not all channels have a sibling, but if user_count > 1 there is
> > 	one.
>=20
> Let's figure out which solution would be the best, and I will add comment=
s
> for any of the unclear things.
>=20
> > >
> > > -		prescale =3D rz_mtu3_pwm->prescale[ch];
> > > +		if (rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, sibling_hwpwm)) {
> > > +			if (rz_mtu3_pwm->prescale[ch] > prescale)
> > > +				return -EBUSY;
> > > +
> > > +			prescale =3D rz_mtu3_pwm->prescale[ch];
> > > +		}
> > >  	}
> > >
> > >  	pv =3D rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);
> > > @@ -371,7 +385,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > >  	if (rz_mtu3_pwm->prescale[ch] !=3D prescale && rz_mtu3_pwm->enable_=
count[ch])
> > >  		rz_mtu3_disable(priv->mtu);
> > >
> > > -	if (priv->map->base_pwm_number =3D=3D pwm->hwpwm) {
> > > +	if (is_primary) {
> > >  		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> > >  				      RZ_MTU3_TCR_CCLR_TGRA | val);
> > >  		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRA, pv,
> >
> > All in all I'm unhappy with the hwpwm to channel+IO mapping, this makes
> > this all more complicated. This is something that already bugged me whe=
n
> > this driver was created.
> >
> > It's out of scope for this series of fixes, but I wonder if we could
> > create a mapping from hwpwm to an IO-id like this:
> >
> > 	hwpwm | IO-id
> > 	------+------
> > 	   0  |    0	(channel 0, io 0)
> > 	   1  |    1	(channel 0, io 1)
> > 	   2  |    2	(channel 1, io 0)
> > 	   3  |    4	(channel 2, io 0)
> >            4  |    6	(channel 3, io 0)
> > 	   5  |    7	(channel 3, io 1)
> > 	   6  |    8	(channel 4, io 0)
> > 	   7  |    9	(channel 4, io 1)
> > 	   8  |   12	(channel 6, io 0)
> > 	   9  |   13	(channel 6, io 1)
> > 	  10  |   14	(channel 7, io 0)
> > 	  11  |   15	(channel 7, io 1)
> >
> > then the sibling would be just `io_id ^ 1` and the channel could
> > be computed by `io_id >> 1` and the base id for a given io is just
> > `io_id & ~1`.
> >
> > Tracking of an IO being enabled could be done using
> >
> > 	enabled_io & (1 << io_id)
> >
> > I think this would be a simpler scheme that needs less memory and less
> > pointer dereferencing and the check for the sibling being enabled would
> > also be a trivial bit operation.
> >
>=20
> I agree that the current setup is not the best. Especially the loop insid=
e
> rz_mtu3_get_channel() is quite sub-optimal, in my opinion.
>=20
> I have many more patches already implemented and prepared to be sent for
> MTU3, including conversion to waveform APIs, a lot of cleanups, support
> for more prescale values, bootloader handoff support, etc, but I have
> sent the fixes first as they are higher priority.
>=20
> I will try to implement your mapping improvement idea and integrate it in
> one of the later series of patches.
>=20
> Please let me know which solution you think is the best for dealing with
> the issue the current patch is trying to solve, and I'll continue from
> there.
>=20

Hello Uwe.

What do you think about this setup for mapping from PWM to HW?

#define RZ_MTU3_PWM_IO(ch, secondary) \
	(((ch) << 1) | (secondary))

#define RZ_MTU3_PWM_1_IO(ch) \
	RZ_MTU3_PWM_IO(ch, 0)

#define RZ_MTU3_PWM_2_IO(ch) \
	RZ_MTU3_PWM_IO(ch, 0), \
	RZ_MTU3_PWM_IO(ch, 1)

static const u8 rz_mtu3_pwm_io_map[] =3D {
	RZ_MTU3_PWM_2_IO(0), /* MTU0 */
	RZ_MTU3_PWM_1_IO(1), /* MTU1 */
	RZ_MTU3_PWM_1_IO(2), /* MTU2 */
	RZ_MTU3_PWM_2_IO(3), /* MTU3 */
	RZ_MTU3_PWM_2_IO(4), /* MTU4 */
	RZ_MTU3_PWM_2_IO(5), /* MTU6 */
	RZ_MTU3_PWM_2_IO(6), /* MTU7 */
};
static_assert(ARRAY_SIZE(rz_mtu3_pwm_io_map) =3D=3D RZ_MTU3_MAX_PWM_CHANNEL=
S);

static unsigned int rz_mtu3_hwpwm_ch(u32 hwpwm)
{
	return rz_mtu3_pwm_io_map[hwpwm] >> 1;
}

static bool rz_mtu3_hwpwm_is_primary(u32 hwpwm)
{
	return !(rz_mtu3_pwm_io_map[hwpwm] & 1);
}

static struct rz_mtu3_pwm_channel *
rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 hwpwm)
{
	unsigned int ch =3D rz_mtu3_hwpwm_ch(hwpwm);

	return &rz_mtu3_pwm->channel_data[ch];
}

This gets rid of the loop inside rz_mtu3_get_channel() quite nicely.

priv->map->base_pwm_number =3D=3D hwpwm checks will in turn be reduced to
rz_mtu3_hwpwm_is_primary(hwpwm).

If you decide that we should keep the sibling check inside
rz_mtu3_pwm_config() as-is then we can do the following, without having
to encode the number of channels for each HW channel explicitly.

Please note that hwpwm + 1 is fine in this case as the last hwpwm of
rz_mtu3_pwm_io_map is never primary.

static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)
{
	if (!rz_mtu3_hwpwm_is_primary(hwpwm))
		return hwpwm - 1;

	if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
		return -EINVAL;

	return hwpwm + 1;
}

Although, I would much rather have the following logic rather than the
sibling check, which matches one of the alternatives you proposed earlier.

Hopefully, the comment explains the situation well.

static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm=
,
			      const struct pwm_state *state)
{
	...

	u32 enable_count;

	...

	/*
	 * Account for the case where one IO is already enabled and this call
	 * enables the second one, to prevent the prescale from being changed.
	 * If this PWM is currently disabled it will be enabled by this call,
	 * so include it in the enable count. If it is already enabled, it has
	 * already been accounted for.
	 */
	enable_count =3D rz_mtu3_pwm->enable_count[ch] + (pwm->state.enabled ? 0 :=
 1);

	...

	if (enable_count > 1) {
		if (rz_mtu3_pwm->prescale[ch] > prescale)
			return -EBUSY;

		prescale =3D rz_mtu3_pwm->prescale[ch];
	}

Please let me know what you think so we can proceed with the work
internally.

> > Best regards
> > Uwe

