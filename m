Return-Path: <linux-pwm+bounces-8204-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LY5KNPWqmnfXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8204-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 14:29:55 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C63F2219F2
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 14:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C162330A414C
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2026 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE339A069;
	Fri,  6 Mar 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="bPNKS921"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011058.outbound.protection.outlook.com [52.101.125.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7E39B94D;
	Fri,  6 Mar 2026 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803608; cv=fail; b=Ba65dSbILJXc4s7Hd7ZXL0cbGnqPbI/+/31cTFkoaup6MbSMCzCeeSxZCRVSVF8kJJncY7gzznXha0dFziSWrFZqWVIa+cJe54PPz/xqbPQM/Afjn4x+3Q1/vsg4VI/X4b2/+9PESaQbDzyv6EaRzLfMfgtDgpGQkx8o24rWR9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803608; c=relaxed/simple;
	bh=4o/K/zqrfxiWxZBvGF95qbf8ERumHH8AlLgA0zKu+Mw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nDwcd78+0wBMSLRLawqXvEFV0TAh6j6ntO9yrfEeA5m0abQIw7j4S4nY0m6JtAslNYmZlGSontMfAAzOJhEX6VVu7Iq2Rjx15SFc6rxYg7q0YJIOfgNnhguUXxPyCaHy11o1RsT0ISLGcax/SGC0BxGCh4dzySE+H7gV+Tnmxi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=bPNKS921; arc=fail smtp.client-ip=52.101.125.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIvHWrQyTKFVEcCTS2hn3v9QInhViiZ8h9Hl3uH4A6eEDnebHjMZAplF9kPsYG89geK0ceTCGtxV5ElGyXbfxhKfzsVMTDQtTbSiAlFQO35xee6f7yVHca+UsTMkp2oBf9rv6FUFU+ME/I5LyGA8EfVwqTCobTMiCpRSewctEjisSPG6sxDmyRWKk5z6SQQOIp64EVZiWZWXJMtamnz/hh9EAw+j1ljXPudQGKiKb/LYxk8bit3OXEskYX3sRKXt1uxQn+xxfWe7o1ZRtTidHm4RnHQL8rt2u5/pfVJyS4XkSgJU94oXg5iXVkGRs3us8a3CVd2n4x/8Sr6ORtz0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvGnCclna6+Y6cNa/DyfB/yak42I1TJdI/7yc8KVWDI=;
 b=YtGq9HfdKs4b0x5RmEXWhvzAIGCWgL6wylA7dalPIk86JflYNKaSVezy8XPYe2se4/82NgJeKea697gduKrazHFgm7ESqGS8/0xrp1sBKg4NUvhFY5vw6JLgD4odmf+gFUQmlG11FXsz1/9w3lsWpP0oAQ90V6WTtFgPkf+DfEphnENoVJy3744laEwNMWdqAX3cs4Nyy+eptDcIVApDmM1fSuwyZ3XchKCuif4DX0OXP8ceT7+KGYt+NHy2+nUFxkg/k2dvpaJPGU6HQNYw+1OW/QTUByGKA1LuBv2InCQuhr23VywH+5mxRS8nQYPd+Rfl5tJ+AIRjgVWh2Z10ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvGnCclna6+Y6cNa/DyfB/yak42I1TJdI/7yc8KVWDI=;
 b=bPNKS921n6LZ4UZwtSlkBqSFS+hUi1Lan7vExNynAaVyqZLOatoe9TYq1gBY2cE17SYVceCvEZE7dsDhhI6ZZ+XdrfiOIKcrztAHogxUoW1wXOJHO9v662J9BX1PuS/oAAfhP7JNSTrJrwPec3CmJt7Nxtqov8u7jEvm6lGX8us=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TY7PR01MB15780.jpnprd01.prod.outlook.com
 (2603:1096:405:2c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 13:26:42 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 13:26:42 +0000
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
Thread-Index: AQHckeNxm+l5nvVDhECE0kd9r0GiYLWhc7cAgAAuuBA=
Date: Fri, 6 Mar 2026 13:26:42 +0000
Message-ID:
 <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros>
In-Reply-To: <aaqTVDQa7xn70bR_@monoceros>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TY7PR01MB15780:EE_
x-ms-office365-filtering-correlation-id: e7e3b230-0465-4f89-8588-08de7b840178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 1Scu51H8ipG8skC6/pgunltNIdYFFTcjZOE/o8t8yW8zTNRf0d6Y2p9VolgelrdQdi7AbUnfZrP0d7bcwMctpctcrERIg5afTZbiuM6WUE2VnV8le/UHK/PR4fQkbmTetOc2I6bdc4NrU7ysE7Tz56zf+iQ0j4nypvod5aoq6dCGmHycXCMLEGFmkNP96cSzM1+7Y/WPOMrAkm6twAHS2E42NbOIGUcCPuXQtoEfc+E/YYNzPZz5My9N12WiTveF0m6CtVOjm5VUlGGmgSwmKSi3OG3aCg5OykvoA5H40Q/mv7TSk8g+MLonVSU9OcwCrsFuUcGtlwsGypTvrOlBhnyLYuLOPxGbqYgwbZrabVtcgRVCAye+CT9ksg1abzYhd0hM9LD2mvIW00BKllAv8ARbpPKq5kpcPCfBbVtRoxKf0kkNU7qV9/7BL5dNh9rLyVO/hkJImh2zToUEU7L+iaQR+7C9Y2Z/Gfm60NQucUy1x2pk9VainLeaDI05ssde0wEOob52WogB8+ia748RJBr4TZKVyyVDs/8T/+Jqc5kwPxjLofKEpB4A24nrhvsf16SFUMyTV5AsfL9NdRt6F7P0u9ZoCexLxn3mZWiagLac96MPdTu9njrWp6O8zRzOEG5CBeL3skcoS0nlnUr0VOcHKob0LSrpYm5j1SK6VfQF49B8lCBjMsH0h95GXsmRCGeMAbGJ7Yx6bJfwVfbJxHgbv5r8xbNHMaMcjQdzpVADc+1l1sQsg66bFgV/LeoRjE3Kg4ygZkR+YVdCRaM5CpwZCctIWScnsuO1wZcNmxw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AcaMAIhvxKhFD7pkLKAWqHcMUXHtQ5XsFaF9aT9sPav7jLcWaMc/ffCa8g?=
 =?iso-8859-1?Q?9ivF4JXVMXCc2ogoxDnZJahgOmtGtqPBWFo6ei0H6yADVCwTPbkgrveBEz?=
 =?iso-8859-1?Q?QnKWmiG15UsWXhgEjV/484Pdj45odNztC4q5JDV7AcQPxMWod4mzUi1RIh?=
 =?iso-8859-1?Q?tpk5wVHAbkBlJnNgEcAEqQCBhOwCg1uJTB4fyrnEWc0j5s95CA5GOshIru?=
 =?iso-8859-1?Q?5EUrStH9DBcegiDZwSvXF+ZN3nFqecTZ9Y/sn+OmZyHfxmcP/seWKOJy8h?=
 =?iso-8859-1?Q?lzI+5O5MTZubqbIDnZk+uNvBI1Cquv0lig7KeJnPmkdXBVwt6MWIbpT0SX?=
 =?iso-8859-1?Q?FqLZW8p4EEQn++Nlm5LgNA5PCV2NgQuw0IC6bw3AGxPYA5/4X8qwZoDxO0?=
 =?iso-8859-1?Q?QVr3D62JO7wjMQTnBdBWSkWGgd6iP29Tj+ja7YDOxZ/4b6EkgISLlMt01o?=
 =?iso-8859-1?Q?ZR8HS+8sSSNebPRMIn1/esIy/bCyJIYE7fHiSS71lW0p/OSCCEZ+YYA+MU?=
 =?iso-8859-1?Q?5k5/6zNsCbQ60CjqtoR40uBP+wHTwxyWNLdsqY7pm1ErqHjOAO6KHdX/qe?=
 =?iso-8859-1?Q?k+N1SeCIsB3pWT1/w4z1ajQK7zJiUjOeCeWniX2KMGxi0ad72c0jLrDw96?=
 =?iso-8859-1?Q?YfQ026EfONRqFgUkt0+Ywwat65g1GliC4W138CiRXiJequuS6IcSovXFbd?=
 =?iso-8859-1?Q?ZF7ei//G7qB8KlopziACY4Uy/aWoKA/Tc9Otuk9aKVeaxeJz9AhfHKUEwY?=
 =?iso-8859-1?Q?SRAC+JyzjTB5S7bCO4FoCNVz7kHdiDNMa/L99YpU57d7skO/o23Fy6OiGm?=
 =?iso-8859-1?Q?K7sqe+Q94QTCFfxeGWVw15GBJRll1M/MDJh249yOpU2jWKixiQa2YhJMt+?=
 =?iso-8859-1?Q?fZRxUSJzxw0KaupPEko0tCyAbKWemCg5ob9Le8IWLrP6wg0t0b9mgE6Wol?=
 =?iso-8859-1?Q?Gq8lKU5Kl62uBI8sy03obgEZPwSysaR96aR34UoWkvbLPXHSXi895L1gXP?=
 =?iso-8859-1?Q?83Ma8ob/P20zbQygJHtKW0sF0LNvNbQUnFO9BtkGw5HIr5t6rPwOHk2bBX?=
 =?iso-8859-1?Q?GsyjiCbCuU+xrVsZv2XY0AeZ4+tXa6RNYDf7dn5Erj0tk3BXC8chfmifV9?=
 =?iso-8859-1?Q?DweNfbhPYVE2hp++NNJ/lm/78HbCkto2NbFBsqEHfR01hdVTDYD9x5Ym/E?=
 =?iso-8859-1?Q?zqILuTwJZCVdQqQR3lMvhP9jc2vXIws6HROlY8OC7GTupDbmAh3F9j0y/W?=
 =?iso-8859-1?Q?LThsiYnyJAM3KDc4OiOtVSlZ/VCj8kT6xiYOfLtwlcZjDO23lcJpPTiSSy?=
 =?iso-8859-1?Q?vw8Q5aNLgEbDbLo4HlI5b5ywYQnfDwUgx7WSDo/ect8BDWyO+h68TfeGVU?=
 =?iso-8859-1?Q?0/n8Jrf9uRSxjcgWG599zB9uTQwhonpWlLJFVVAsBKi1+Qd/v06TFCcAWP?=
 =?iso-8859-1?Q?qKWWB9AVUlqcqMQvtn3bSz97QU6RbHmaluOPsmmGjs5ODgVY3N33fjUwUt?=
 =?iso-8859-1?Q?dYKfhI3nCYA2mqiU9KN9dcfJr70VDRzhmXpCU1dsj6wyb//0G4+xdU2r7s?=
 =?iso-8859-1?Q?Dy7bNQ8ngsVdEpvbZDcbLje6R+rwGsmeCbsFomZW3dyliKnXuxdmDdgovn?=
 =?iso-8859-1?Q?Q9oS+csxarz8JuUUzZPgRlwl/4lW29ZsekM9pTOvrbzuanhctkTfvR4xsB?=
 =?iso-8859-1?Q?0DXC4FzHOdBXQpL0LVlLh10a/4BxyLIZ7L/V4V3k+Nguicx55j1tC2MC88?=
 =?iso-8859-1?Q?bU9VGjvchMq5KVy12f3BNe8GN9sShxUVzywJDmsg/bKMmXZeB3MollyqqJ?=
 =?iso-8859-1?Q?eeXkwzeIF0xrhSRVzHQNHvpVBt9Ec9m1SuIy5Aw4VLyNkM5WXGPi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e3b230-0465-4f89-8588-08de7b840178
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 13:26:42.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZ947HmVjSk2/JPC67YmAsDAOzc9y8gbYEdmzDViAZhQ+xn1Dir/eLmejZ+9kBBH4MNnqWYbWOg4xAp6k++r0LWWZcFLoKJlTGSIuCRd4qRx7UtHu77uuS8tDTTqJCmO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB15780
X-Rspamd-Queue-Id: 9C63F2219F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8204-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,renesas.com:dkim,renesas.com:email]
X-Rspamd-Action: no action

> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: Friday, March 6, 2026 11:30 AM
>=20
> Hello,
>=20
> On Fri, Jan 30, 2026 at 02:23:49PM +0200, Cosmin Tanislav wrote:
> > enable_count is only incremented after rz_mtu3_pwm_config() is called
> > for the current PWM channel, causing prescale to not be checked if one
> > PWM channel is enabled and we're enabling the second PWM channel of the
> > same HW channel.
> >
> > To handle this edge case, if the user_count of the HW channel is larger
> > than 1 and the sibling PWM channel is enabled, check that the new
> > prescale is not smaller than the sibling's prescale.
> >
> > If the new prescale is larger than the sibling's prescale, use the
> > sibling's prescale.
> >
> > The user_count check is ensures that we are indeed dealing with a HW
> > channel that has two IOs.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > ---
> >  drivers/pwm/pwm-rz-mtu3.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
> > index ab39bd37edaf..f6073be1c2f8 100644
> > --- a/drivers/pwm/pwm-rz-mtu3.c
> > +++ b/drivers/pwm/pwm-rz-mtu3.c
> > @@ -142,6 +142,14 @@ rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mt=
u3_pwm, u32 hwpwm)
> >  	return priv;
> >  }
> >
> > +static u32 rz_mtu3_sibling_hwpwm(u32 hwpwm, bool is_primary)
> > +{
> > +	if (is_primary)
> > +		return hwpwm + 1;
> > +	else
> > +		return hwpwm - 1;
> > +}
>=20
> Can we please make this function a bit more sophisticated to not need
> is_primary? Something like:
>=20
> static u32 rz_mtu3_sibling_hwpwm(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u3=
2 hwpwm)
> {
> 	struct rz_mtu3_pwm_channel *priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, hw=
pwm);
>=20
> 	BUG_ON(priv->map->num_channel_ios !=3D 2);
>=20
> 	if (priv->map->base_pwm_number =3D=3D hwpwm)
> 		return hwpwm + 1;
> 	else
> 		return hwpwm - 1;
> }
>=20
> (Or if you want to save the rz_mtu3_get_channel() call, pass priv to
> rz_mtu3_sibling_hwpwm() which is already available at the call sites.)
>=20
> And well, BUG_ON isn't very loved, so either it should be dropped or the
> issue escalated in a more civilized manner. I keep it for the sake of
> simplicity during the discussion.
>=20

I can do that. And, to avoid having the BUG_ON(), we can make it return
an int and receive a sibling_hwpwm pointer as an output parameter.

With that in mind, this patch could be simplified to the following diff
(approximatively, I haven't tested it yet).

Please let me know what you think the best solution would be.

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index ab39bd37edaf..4548af0c3b3c 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -142,6 +142,20 @@ rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3_p=
wm, u32 hwpwm)
 	return priv;
 }
=20
+static int rz_mtu3_sibling_hwpwm(struct rz_mtu3_pwm_channel *priv, u32 hwp=
wm,
+				 u32 *sibling_hwpwm)
+{
+	if (priv->map->num_channel_ios !=3D 2)
+		return -EINVAL;
+
+	if (priv->map->base_pwm_number =3D=3D hwpwm)
+		*sibling_hwpwm =3D hwpwm + 1;
+	else
+		*sibling_hwpwm =3D hwpwm - 1;
+
+	return 0;
+}
+
 static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_pwm=
,
 				      u32 hwpwm)
 {
@@ -321,6 +335,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
 	struct rz_mtu3_pwm_channel *priv;
 	u64 period_cycles;
+	u32 sibling_hwpwm;
 	u64 duty_cycles;
 	u8 prescale;
 	u16 pv, dc;
@@ -340,7 +355,9 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
 	 * different settings. Modify prescalar if other PWM is off or handle
 	 * it, if current prescale value is less than the one we want to set.
 	 */
-	if (rz_mtu3_pwm->enable_count[ch] > 1) {
+	if (rz_mtu3_pwm->user_count[ch] > 1 &&
+	    !rz_mtu3_sibling_hwpwm(priv, pwm->hwpwm, &sibling_hwpwm) &&
+	    rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, sibling_hwpwm)) {
 		if (rz_mtu3_pwm->prescale[ch] > prescale)
 			return -EBUSY;


> > +
> >  static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3=
_pwm,
> >  				      u32 hwpwm)
> >  {
> > @@ -322,6 +330,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >  	struct rz_mtu3_pwm_channel *priv;
> >  	u64 period_cycles;
> >  	u64 duty_cycles;
> > +	bool is_primary;
> >  	u8 prescale;
> >  	u16 pv, dc;
> >  	u8 val;
> > @@ -329,6 +338,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >
> >  	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> >  	ch =3D priv - rz_mtu3_pwm->channel_data;
> > +	is_primary =3D priv->map->base_pwm_number =3D=3D pwm->hwpwm;
> >
> >  	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> >  					NSEC_PER_SEC);
> > @@ -340,11 +350,15 @@ static int rz_mtu3_pwm_config(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> >  	 * different settings. Modify prescalar if other PWM is off or handle
> >  	 * it, if current prescale value is less than the one we want to set.
> >  	 */
> > -	if (rz_mtu3_pwm->enable_count[ch] > 1) {
> > -		if (rz_mtu3_pwm->prescale[ch] > prescale)
> > -			return -EBUSY;
>=20
> OK, I understood the issue. If the sibling is already on and the current
> IO is still off, enable_count doesn't account yet for the current
> IO and thus is 1 but still the prescaler must not be changed.
>=20
> The commit log needs updating to make this clearer.
>=20

I'll try to rephrase it to make it clearer.

> An alternative would be to check for
>=20
> 	if (rz_mtu3_pwm->enable_count[ch] + (pwm->state.enabled ? 0 : 1) > 1)
>=20
> but I'm not sure this is better.
>=20

This was essentially my initial solution internally, but it was argued by
my colleagues that it would be difficult to understand.

The solution that I ended up submitting here is more explicit and easier
to grasp at a glance, at the expense of being lengthier.

I still quite prefer the shorter solution, as it is not necessary to query
the actual hardware state in this scenario, as the PWM state should always
be in sync with it.

The PWM state is enough to figure out the effective enable_count, as we can
only make it into this function when
a) the PWM channel is already enabled and it is being updated OR
b) when the PWM channel is being enabled (and it was previously disabled).

> > +	if (rz_mtu3_pwm->user_count[ch] > 1) {
> > +		u32 sibling_hwpwm =3D rz_mtu3_sibling_hwpwm(pwm->hwpwm, is_primary);
>=20
> Maybe add a comment here saying something like:
>=20
> 	Not all channels have a sibling, but if user_count > 1 there is
> 	one.

Let's figure out which solution would be the best, and I will add comments
for any of the unclear things.

> >
> > -		prescale =3D rz_mtu3_pwm->prescale[ch];
> > +		if (rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, sibling_hwpwm)) {
> > +			if (rz_mtu3_pwm->prescale[ch] > prescale)
> > +				return -EBUSY;
> > +
> > +			prescale =3D rz_mtu3_pwm->prescale[ch];
> > +		}
> >  	}
> >
> >  	pv =3D rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);
> > @@ -371,7 +385,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >  	if (rz_mtu3_pwm->prescale[ch] !=3D prescale && rz_mtu3_pwm->enable_co=
unt[ch])
> >  		rz_mtu3_disable(priv->mtu);
> >
> > -	if (priv->map->base_pwm_number =3D=3D pwm->hwpwm) {
> > +	if (is_primary) {
> >  		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> >  				      RZ_MTU3_TCR_CCLR_TGRA | val);
> >  		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRA, pv,
>=20
> All in all I'm unhappy with the hwpwm to channel+IO mapping, this makes
> this all more complicated. This is something that already bugged me when
> this driver was created.
>=20
> It's out of scope for this series of fixes, but I wonder if we could
> create a mapping from hwpwm to an IO-id like this:
>=20
> 	hwpwm | IO-id
> 	------+------
> 	   0  |    0	(channel 0, io 0)
> 	   1  |    1	(channel 0, io 1)
> 	   2  |    2	(channel 1, io 0)
> 	   3  |    4	(channel 2, io 0)
>            4  |    6	(channel 3, io 0)
> 	   5  |    7	(channel 3, io 1)
> 	   6  |    8	(channel 4, io 0)
> 	   7  |    9	(channel 4, io 1)
> 	   8  |   12	(channel 6, io 0)
> 	   9  |   13	(channel 6, io 1)
> 	  10  |   14	(channel 7, io 0)
> 	  11  |   15	(channel 7, io 1)
>=20
> then the sibling would be just `io_id ^ 1` and the channel could
> be computed by `io_id >> 1` and the base id for a given io is just
> `io_id & ~1`.
>=20
> Tracking of an IO being enabled could be done using
>=20
> 	enabled_io & (1 << io_id)
>=20
> I think this would be a simpler scheme that needs less memory and less
> pointer dereferencing and the check for the sibling being enabled would
> also be a trivial bit operation.
>=20

I agree that the current setup is not the best. Especially the loop inside
rz_mtu3_get_channel() is quite sub-optimal, in my opinion.

I have many more patches already implemented and prepared to be sent for
MTU3, including conversion to waveform APIs, a lot of cleanups, support
for more prescale values, bootloader handoff support, etc, but I have
sent the fixes first as they are higher priority.

I will try to implement your mapping improvement idea and integrate it in
one of the later series of patches.

Please let me know which solution you think is the best for dealing with
the issue the current patch is trying to solve, and I'll continue from
there.

> Best regards
> Uwe

