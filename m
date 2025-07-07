Return-Path: <linux-pwm+bounces-6763-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1CCAFB7E6
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5B97A330D
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1D212B31;
	Mon,  7 Jul 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="RMW5A/1w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D721170D;
	Mon,  7 Jul 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903392; cv=fail; b=CtuKLDDqngJXzlLOPgy7ifPNhblHbvBiRQvXYpg+BA57Q/d6ZYOMdsZvTdtWI7dxmhvWPlo4OeQUbfYfXm4AK8OijBqWd52kWSFwt2I3q5UV6fXyXCqmjljMFk6rStpn/46Y/9yB5NPYF6oFRyJi7aXJjxkoZwdlh221dtZcE0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903392; c=relaxed/simple;
	bh=lwx1mFlRrLHJuFFKyhoFLLigkt5uYNH0CDwwdw1FUcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GwfeM4wMCyt7P6kO99Ruif5nbDJhTq0NF/oCoyeAh+UZHhhYsn+zXpdHD/de9N9pB77J7qffKR6MROYzKBmQAbzJ+OkEqh1YepySaZJ9fipXj0GKYBXXPJrhChaQWqTSW7WMJz7numCZDhcTsn7t5kczjCUSXsKUAheD0qzM96s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=RMW5A/1w; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5U6g8Ytf3c9KH1qVNSp8Tu8mDX9xBqu4wdCpgYSIImEpT1rAxO/i+maUMLkyhlGMKjFoP/Tl/U659ISgr3FuWhAn7+bOkFYXXX36cjXfSY+9jP1PJFIwMWbY2kMuYITlqO8bpSL+JgyMXdohF9Zx9KCNVtg4oYwJbl1XOFkUrnGMAFyj157fud2oRMp3Pc/7TfmjF5zPXauyUWBDhYmeZM7ls0f1MZzfZ/KLMJlUtVkdLqke5Yw2iO2beJyAZ8hmAQ7+cFAZafJAYyrsOMEfkCScRbkWWptKW0SvY4f2mUBGwpy792zuHL2SoKzGA+Jh7nuCgH/zC8n8d+wV5HD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwx1mFlRrLHJuFFKyhoFLLigkt5uYNH0CDwwdw1FUcY=;
 b=efU1lBUfflw9tk7CwO7lTXFjvVXpG4tqobNHCuZDc4mczQ4ubCssCAmXIuAhFiONZUXs4eQ06tWL8zsG3GgYOLjiyF/anFdFvuLkUqpgTuYoOZMyBqoSkAtzENNprhxXNF9Hxmrn5aOuZ4xXu349FPT6foCBVyT25eEXlvm7Y3BMtBzr80BnctkIVxLS4E6ha5yWeDg6oMwqloFZqnhijsHK8ipVO6liHK9yxtU0B9ryuYiAyidifctqheyF5m4dYPLkIMWOrrwBOB0tXpwR6yVJE5Ag1DIxaxQmoLVHBHVF5ZysXFS93g8CHDI4dbSWrqYcCXeT6ZufX8+e/xrmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwx1mFlRrLHJuFFKyhoFLLigkt5uYNH0CDwwdw1FUcY=;
 b=RMW5A/1wJLzRnuBRqwA/pXBNgsNToVzvitUFwUj5aM6PGPHzLN4m9iFW47dQ8t7mZQz47YfnWKkhnrcX8Rty35MiYLAN2zIEGOlB/564qleoZHTMfZUL9PgsYZC5mvkENUGFNY5RfFmGNt/nf2O5SotHDHUN50w3gyWNaO7u5V7Mr2jYCVG5WV9oOxOrSLKLsW5aLBx/mi/iQsZm5pdoCfCq1mR5ru42NzP9eZtdGl/9AcocHjsW/iIUElseio43eyeWvqW0y1F+BBxN70yGnADkkNDh/hvbT0mLZdj/L4w+pV3DhuOpE4aamZOMmRywYIocEKBfeGqmPnlK0hEjWg==
Received: from PH0PR22MB3789.namprd22.prod.outlook.com (2603:10b6:510:29c::11)
 by CH3PR22MB4492.namprd22.prod.outlook.com (2603:10b6:610:197::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 15:49:48 +0000
Received: from PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::e21a:e0c7:aff:b839]) by PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::e21a:e0c7:aff:b839%5]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 15:49:48 +0000
From: FLAVIO SULIGOI <f.suligoi@asem.it>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Lee
 Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo Han
	<jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: EXTERNAL: [PATCH 2/2] backlight: mp3309c: Initialize backlight
 properties without memset
Thread-Topic: EXTERNAL: [PATCH 2/2] backlight: mp3309c: Initialize backlight
 properties without memset
Thread-Index: AQHb6mm6N9q3MyMLLk6n5vlw7xwq2rQm2HsA
Date: Mon, 7 Jul 2025 15:49:48 +0000
Message-ID:
 <PH0PR22MB3789366DEA5785915D00581FFA4FA@PH0PR22MB3789.namprd22.prod.outlook.com>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <14514a1b0d3df6438aa10bb74f1c4fc2367d9987.1751361465.git.u.kleine-koenig@baylibre.com>
In-Reply-To:
 <14514a1b0d3df6438aa10bb74f1c4fc2367d9987.1751361465.git.u.kleine-koenig@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_ActionId=26e292e8-8e70-4dcc-b863-58df70a0592c;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_ContentBits=0;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_Enabled=true;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_Method=Standard;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_Name=e14c1950-b3a8-4278-88f1-6df69d73b9d5;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_SetDate=2025-07-07T15:48:59Z;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_SiteId=855b093e-7340-45c7-9f0c-96150415893e;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asem.it;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3789:EE_|CH3PR22MB4492:EE_
x-ms-office365-filtering-correlation-id: 691ed608-46c8-418d-18ae-08ddbd6de729
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yhsSv6OOW2JYuMSwNRU+iXky+2kI0lmtDC4lZW/0nsaEtJ1IJ2wJgYvudu?=
 =?iso-8859-1?Q?bjGb/hInNv21FNx9SRhoYlmey5zzJJ+/bVK/1ZHCfVrfKVURPJmWuvjnci?=
 =?iso-8859-1?Q?PFEbesbKQS5armfFCyidBQCj+lXQqkI30ZpLz7dmcB+oZnLodZnYHN3BBy?=
 =?iso-8859-1?Q?5o4rAiO9iJKPVU70oudfC5kdb8eaJLtW7oWvDpEqfwDJOn44C+NnOVkmbz?=
 =?iso-8859-1?Q?n12vp3yYhQCy2s+pINDYDze9/5igBuWr9mus6TG9Yv1FgQwSJ5p1mUENMr?=
 =?iso-8859-1?Q?n6nSkdj56B5a+ray/wrjQoFuk6xTS7uZwmHH77HgpXVZH1WVbbota5SHfu?=
 =?iso-8859-1?Q?r3HDi0BxP4n0THCVauOt4ZwCZzrVHGvfUFGV256Oq9k/p9Ofv9Ae4+b4Is?=
 =?iso-8859-1?Q?8F762Tg5UvZDz3Ftb5Sy+4+n8koRDAAr3Tm8TfX0fL5q/GqR2EQCYbQ04Q?=
 =?iso-8859-1?Q?5F4dNXt+vSb4yOXkTTdJUY5TgnvbKyDZd8PaQhi2dWyCfNV8xzpirGhLk1?=
 =?iso-8859-1?Q?LwUvO2PTX9LOR3U1eCuG4u2gKIYbHk5H9Aq6c5WaVrW6SdvkVHrxYXisUq?=
 =?iso-8859-1?Q?V39qHXs4iikg6qMa2n4UITVgwZmWuf46yXNwBdhDQj7u4wV4H+REc+6dpv?=
 =?iso-8859-1?Q?ztW2QV19h580gt8Ly+i4W+CFXTyPZe+FLcHyC1CGyuG1+Xq0ZqBceqYBpa?=
 =?iso-8859-1?Q?qewRsLwB2hXRMWVEssJLMUzcUdWbZd6KozcJLhrQIGw6G4EQY7gIJSlqFu?=
 =?iso-8859-1?Q?/6Km+J+6B1a0taoK6DltBqvZoPRzeByIcy6RsEk6R9BFUafPR/7aVbx/IV?=
 =?iso-8859-1?Q?qoIQX+Owi6nzTSYRDMFdPWAcp6rtNwUtFPWBbrR9GMuWxVKCqfBkTrKLQ6?=
 =?iso-8859-1?Q?Fl4EP+tyh3D6opA625/g96LeejZSuF15gl4/PHdhI6ScYfFvl4ai8/VflZ?=
 =?iso-8859-1?Q?vVyBHcLbDn8ZSY/gIXJTpfjLzFKWVhf9yLRN+rOvM3qa46wO9kmfbowR9l?=
 =?iso-8859-1?Q?7pqweo2KBtk3Wki8+UwNPgbstXLDW+PrJSqstmIwq7SfGeIKma6jcJ34dL?=
 =?iso-8859-1?Q?Nyoz8Jtz7AbaarbqwDGBHFxQJG2eoDAAtc5G3bx2vIGB81nrzntPvYG2la?=
 =?iso-8859-1?Q?9I9uYYAeO+8tLs6L80i7AlbceA76Awi4BFZHHcqTUi906BNi8eYe+ltv69?=
 =?iso-8859-1?Q?oun0MKOS+byYJYBJ8wpY+QTmG8PhFtVXZyDQH5ycBBcgVJfS37GBAoESjK?=
 =?iso-8859-1?Q?XCBb/vBrrbJq8WteQYe2Gv8wOtv9ZeyIRBRK2nOPVoEGZFToRV2iugrhp9?=
 =?iso-8859-1?Q?XUyIEwNBJKd7B1vx/62J6n0KEqjTPmb6JAw5xSaRlj5RAbi1ZoLhcNU2Qc?=
 =?iso-8859-1?Q?zz/UTF+jqqQi1y5ywViiRVRtw2HTByIV4QM5lnX26YvZlQR9vqauxd2OVH?=
 =?iso-8859-1?Q?TSU555q3MR0Dsmptox+3xuY+zewKsleQfOwLeTWZ2gzTzl9yPGmCl2Atjb?=
 =?iso-8859-1?Q?/4aUcoCZoIiigTqe8WtEzQhHFod+p0jBLS0Z6expnU7w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3789.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xItkR+xs1o7b86w+VhvL48f8EU2L4f3znjB23ATZBet4qTBCw6A84qbZvp?=
 =?iso-8859-1?Q?911Bt8NnpE8TiU/6mfg6aTm819ApCzlWIaz7v0rm19S8a+6zLJEFgpTfu1?=
 =?iso-8859-1?Q?Ur7+2N26VzPcT5nzUY9iQRilGsqiKPu18Zobmi1paH0EoTfMqqUwxKAZd9?=
 =?iso-8859-1?Q?FIJNUml1rpHcMp+mg2gbxYLbh7gnvpg22zThziIDveLeCINOPO4ea+KZTo?=
 =?iso-8859-1?Q?61JWHPiZHFG1HryCJfxR76ly4enX7O84KM3QezIixHgL9CIA0nboVup29M?=
 =?iso-8859-1?Q?rTB241D6nZJlM8XUdGa0WpQNHy12P6L0rBirnqeN4L8bnTv7CR+cw3R+5W?=
 =?iso-8859-1?Q?9LoBG0xeJgw9aHgXVI38ogNnGfs+pzVa2r1VnfvnpVM++MbcjIwlPGxg6g?=
 =?iso-8859-1?Q?C0Trkb0Ui3nCRjv1WQUvudKd/NucyZfAlDSyk/iU+9wqAMn6Qk77RvieO5?=
 =?iso-8859-1?Q?g7BW/cv7gtNGaXYlz1kMtUZIx6jBY9s31bmJxEeyZD3rMTxXfMeyJGY23O?=
 =?iso-8859-1?Q?H4+KT92E4ud3/9Nfv7OKvUa7WvMzwQDTvo+dsOt8TId10dfmi5DyfqbWKm?=
 =?iso-8859-1?Q?AIbxPwWOZ31bWNAbYAHWe/RVPuisFmcwM1uJYxFr1uo5n8HJatIvQau8wW?=
 =?iso-8859-1?Q?YRDFQ7AKavQIXFlv9HqFsvRGzoO6ccsoFr0Io+aT55zIMwi0jSrvkqlRoA?=
 =?iso-8859-1?Q?OfM+REOAkTfZ7KTh4yzDn5cX2R0RKijuEZnf7HquYOwjRLjhca/ixml7VK?=
 =?iso-8859-1?Q?diVwQazp4SE/E27dGFCHcfb7c0TmbcL6WppZD8vM3cqz/RQNJJ9TU20BsM?=
 =?iso-8859-1?Q?cwMuyAKmC7CahqozotnfHe6KvlBX/89dDUiyNLdlPGvfI2F6ukfvL16al3?=
 =?iso-8859-1?Q?dSEv0vkxVr7mjvTKZu/JmCLslNSL7Q/7OhhkFXPSWDXfktUtjfzbRg6wIJ?=
 =?iso-8859-1?Q?yz05i7jgxDUwGTc9k2tX7UnjntiDckXTBTuH3ozaXsh2q34crwf9B1Koin?=
 =?iso-8859-1?Q?rT8qUVKkc2Zdj82gBDf6Gg5qJFBPF9dJOT1zw3xeMGAh6w0/WBpBpFx8jo?=
 =?iso-8859-1?Q?IFS9QmBA/N5qSG7USZ5zCbqRyCl6z2RkrSFxEew2VKXFB+JV6DN8LNb8wT?=
 =?iso-8859-1?Q?S/ci4dfsoGvQsoLBqYyZXNYszybmaxg3TeZZtFcA47VdsZ8/WVqC/8na13?=
 =?iso-8859-1?Q?s3ViNTJmKA185JPAd74KhdXRgq0lZMECdwCS4mVrYOzFWZ4PAdBrzi0LGb?=
 =?iso-8859-1?Q?TP7EPs07Rsuzbim3vBu3G0eOYBcwRNQfhKQ5TWno0Ne1D/BH95w0pTdxGy?=
 =?iso-8859-1?Q?Wgdu8pZQ4aXVIvrXqtYB97ASfiLO4fdCY9yrfT2fPRfTGno9x3bGKhsDH/?=
 =?iso-8859-1?Q?I0HxlqpGEokt8eche1o8mhgHd2flnMNAgSE/tCJLDnViCXcwL9pH6Q0p8E?=
 =?iso-8859-1?Q?bYZMZEp7ULVk6uuCZ7HGVj9KCMkwr9nLdtTzVvZVUXwYTG2iFVlFK4LUdG?=
 =?iso-8859-1?Q?JoushKyW5LEegZd5qiS2GCwMMEhCp6VVHrdG9YZAQYyd3NRvM+WpFEAL5c?=
 =?iso-8859-1?Q?7W2jD6fiVUbxMEAfwK2VtgCOCkKWjmXQHQnDPVELN6eWy4Cjvji40HyAc5?=
 =?iso-8859-1?Q?Fk53KF0HIG+0KpEJ1OJauj1qpAZINleiEXHWdpDTdHlGgTRm0i2GD7uam9?=
 =?iso-8859-1?Q?BWfx1GgZytx62Myo8gc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3789.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691ed608-46c8-418d-18ae-08ddbd6de729
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 15:49:48.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jp5peCFB1mZh0zU+GLqqg5x8lKWkmO7qUtDmaxQLSF3ep5YoK4trZmw74s3roobQO2YwV9LmZl1k4Wcob94tvyhqXII1SLLlerr/SyvxRuncUMDeUX71gg3jdlyhaqrs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB4492

Hi Uwe,

I've tested your patch on my board, all ok.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Sent: marted=EC 1 luglio 2025 11:23
> To: FLAVIO SULIGOI <f.suligoi@asem.it>; Lee Jones <lee@kernel.org>;
> Daniel Thompson <danielt@kernel.org>; Jingoo Han <jingoohan1@gmail.com>;
> Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org; linux-fbdev@vger.kernel.org; linux-
> pwm@vger.kernel.org
> Subject: EXTERNAL: [PATCH 2/2] backlight: mp3309c: Initialize backlight
> properties without memset
>=20
> [Use caution with links & attachments]
>=20
>=20
>=20
> Assigning values to a struct using a compound literal (since C99) also
> guarantees that all unspecified struct members are empty-initialized, so
> it properly replaces the memset to zero.
>=20
> The code looks a bit nicer and more idiomatic (though that might be
> subjective?). The resulting binary is a bit smaller. On ARCH=3Darm with a=
n
> allnoconfig + minimal changes to enable the mp3309c driver the
> difference is 12 bytes.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Tested-by: Flavio Suligoi <f.suligoi@asem.it>

