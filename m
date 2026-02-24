Return-Path: <linux-pwm+bounces-8156-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HhzJ+5mnWlgPQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8156-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Feb 2026 09:53:02 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DF918404B
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Feb 2026 09:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB1AA30C169A
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Feb 2026 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A57C369217;
	Tue, 24 Feb 2026 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pXoEA85V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010073.outbound.protection.outlook.com [52.103.66.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2675369208;
	Tue, 24 Feb 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923110; cv=fail; b=M17diwDHEtitqiPRf6vkONTRrnlaIKK8vbq+1uRWtL28rhNrkhZXSWKibYFwrgKfJ96TPS9APMnSCd3iGDaENkUnjROsRxFT7GACKWnJ3NQD6vuy/9GvhbxPkR1x0zwytG5UW/qFqfHXzILqM/TLE7sLlO0/0Q6zDhhsgz0+cPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923110; c=relaxed/simple;
	bh=ETdJeGGY/GZsgZmHZcwYNsuh6cqNFpX5g3v81NjD9aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JOmbKMIttG0PZ9cEzesS3pAE7PMoHlyJY3AB0AblQzlsZdLK5cDAadpCuJYWacVeMn3mytLoyk8YIaKaMWTz5KV86ms3gtdRpASHJuockL9hc/ln3H5EJfBh3A7AUriPpfP+7DxE17PsPnUfgsDFs+hcuPHCp9BO73L9sl1TPkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pXoEA85V; arc=fail smtp.client-ip=52.103.66.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fK2Y3+v6FukGrV6qUyHpjGWlOpG+LhmGRVsPRKjsMD9Ppmb3XYSU9bh6ufz+3UsU7CtxualZKPn/b3kw2uYZyrTzQJDjPNVYQYiCRwcSkDdz/x9R/ARCXZYEdN2bfYZtTKNqVJx5yyouIfIvOUbP4YORnFkyGRChBoJsKXRJN9+QH5+VbusSC+4ywjy4NEiYIbpzs2Wg7NplmCW/TRj7VSR825zqS3k7/OxhZkLsaikRKWB/Zgi8fCsEKOLXOG8plhZ6V1lum2lcWwLdTHzBOjqlPyaaiZKbWAAUko2fJ8JIwxLPj0GpIIQh5PYC9jluzF+bBWXvKLq/0Fx8EPZAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRp33ejGUafaDEONHI8sqOqIXeQu1K4R1qm2rIQZY0M=;
 b=mbI9rJEn8uiY7ge4QkHR8e0u6fQ6Q/8a6xNtFVGA5hCaiiSUcTmMjzHoWi+hEccxTQuyNV9mB+LXZj3W3N8b8ho12N7uzBR70AJMKzPxVxxtQxNWBDGvTzbyHDgiy79Tg5FsuxdqTARPP9iQYHdUkTk8ATbpRINEbfqQkFQZzlHMUliUZlxST3iqdygqD8wb9G9Kq5Q8OcQE8Zw3BJBQ+jbONbFhnxzn3TcyEhWsyGscCl52zNzYTXq1C3RRwcW1WPjnbdY6Awpv785LjZQUrAaDB6QOTXl5Va4mrMA3bFRk/vtZy3pnivT7H92BPEO5YVj+R2jWsuHc7WTIyxeBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRp33ejGUafaDEONHI8sqOqIXeQu1K4R1qm2rIQZY0M=;
 b=pXoEA85VCEeXo/d0Yn8WQ1hmUODyZTHIzR9hdUzuaCXI8jbTlHmu3x0ZusZ+9/QFy0Hk0CmY4QOro5reMutR1vSDjwNIHZdiSKzoCDlqko/n1X6hjLQSq1xwOpgYadjH5xFpVVTTqgs1V+snfgfc9RxV7aUG68rRoK0veqVYvy36NaI0lgD2eDT0jrfJd2ASbmyGcCe1dj5I3viOpF3TMckg+9UFDAUIFmDyiCEdzC3FZHYOhwF+9MNZkxmlHV5e2B1dkhnrPKNF0RNDSXyF82RFKVAs77hH/GkvOuG3E/ngKaRbYKCUDkvxMMKKAuQfH+tu/b+lB5E6Q3rKF7PSgg==
Received: from OS7PR01MB13602.jpnprd01.prod.outlook.com (2603:1096:604:359::9)
 by TYYPR01MB12471.jpnprd01.prod.outlook.com (2603:1096:405:19b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:51:46 +0000
Received: from OS7PR01MB13602.jpnprd01.prod.outlook.com
 ([fe80::7a94:8782:9191:8d50]) by OS7PR01MB13602.jpnprd01.prod.outlook.com
 ([fe80::7a94:8782:9191:8d50%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:51:46 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] pwm: mediatek: set mt7628 pwm45_fixup flag to false
Date: Tue, 24 Feb 2026 16:51:01 +0800
Message-ID:
 <OS7PR01MB13602B3C7E43A2E38275C73AEBC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <OS7PR01MB1360282ADC135931ECCAD9AF6BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
References: <OS7PR01MB1360282ADC135931ECCAD9AF6BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To OS7PR01MB13602.jpnprd01.prod.outlook.com (2603:1096:604:359::9)
X-Microsoft-Original-Message-ID:
 <20260224085103.18710-2-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13602:EE_|TYYPR01MB12471:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b3ce9f-e1c6-4271-2480-08de7381f076
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0JsWcHQis/YiQS8IuYgjFzrlz1NsinaGORwfI0TSIxK71GpBO/NA3y9WQxRNEUk53qdCozXfgTYYECpcu4xc/pF4Lt1aGCM8mZqLCVGyKAlAi32HX2WZHjkrH10SMP1X+ovPn5NhItDrOPVTa7WSM2UtBqwlAIg31tQZpwky161HfVqK35yZ5jVnMUUYFNowQGlPNxwKlz1VCAJQwoSTzJ/s98kN6dsTJyFMH2BffJAHojxVU24RWCJgu1ioJF17Mmq1UNFIdSUYuoVaWgTIwW9Yrx8lrU5+a6kWFpZGvAGIP32FDjdFNkVgpfJQwUucZRw0IIbocaKRYi8TVYU7SxvxsTxDWzypZhXPeHn65TyTZrrpkxWKKe0Rw0PmBiKoytPwGKUIxeEPTy33wkSdrthi533VCJ4l6RroCYdbTdJ22kB4aau4XUzFsgiDi5QUlv6w4xZzqzZZ/6+VD2YDvjbRSonFXn1bGgdncUKnP0cmjrPG9hysP/W1U+FjwyyYt8WIm6PBx2ye8mUprnkB6gW3KMXftsi9zuhYzsYVp27+QMGaQxGi7Uyki41qcPR0rIwy1OXPNjyUHRg2ehmySJX6xBsafK7oMfHBvYf63PcVpg7DNGOcr3HaUOmbPIUpgVNVeXsqSA+HS5FLK6N7Hjvlc3krIEec9bhP0I1VJ9mlffEPwrxZooO8MJSZQHm2lG1ywIWYu1P2UrD3luJZMOVVfwThYtKT2pAAteUtJmGs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799015|19110799012|23021999003|15080799012|40105399003|53005399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mAHDXnWLDRlVaoVE+DmTIjRfM+lSC0DzhUVr+fwhOBaSn9dkgyhLmW/uz3wJ?=
 =?us-ascii?Q?Gxe0ngzAyJueXvpPzNVGbfaM+P9py0oAhS9GDWZeOSJqmjOd34wzvTdVvjYs?=
 =?us-ascii?Q?HI8TeWPr8+0c7zUNcTLdglx2A40L07l7bxC9c7i+6ipjGQshH4F+jWfWtglK?=
 =?us-ascii?Q?4M0A7B8JnDxRTngp+8IQjg3BF1x6/XgUoyf/y/EKsH2w944II1GcNamPLaEx?=
 =?us-ascii?Q?uwB/2TIWxaJJAtuALpDEaPC4jVQZT0O/kbmu735u2mWSUAQhQTwvN4Ad6oMy?=
 =?us-ascii?Q?jhrNPay3pVv6DGPEPQEJpqFASErhRa/2DoZV0zaBTLcGfzISmq5861qwFKZQ?=
 =?us-ascii?Q?OUKq3lvYPGFWs94lxKCfgiau3+YlRZOEkN+VVHpEMdbxY08RUfm54gGxNcq/?=
 =?us-ascii?Q?1M6H/aayqnQEmT9K0wggCwDW2/lE/grkVSs9RG8JkBAz0vCuLnD16rRuVTKv?=
 =?us-ascii?Q?epjC4r766fFlD46UHd8L+H63a8xtMTrS/xVV0I4qFAkG7nESnlUhVqV3Jqx3?=
 =?us-ascii?Q?sY98iRcdOqiZgIMBMB2vZkkd6PuxjTmmkE+pfnbp6QZ5oGFGfqlpzgqVWG6M?=
 =?us-ascii?Q?Dd/ZhYi7YLzi7A9iWU2XQY9Os53f6NilC0OAtZxvCO5xPPe5G74WQAUGbwRy?=
 =?us-ascii?Q?EndOI/0xeJpD+ntFPTQVwQ6CQCCxnixxiE8pNsbu0cjh30nJf2cgM+7yCjmq?=
 =?us-ascii?Q?lpf5mTh+IyRhUljzO6IfnpxsWNWSeCJQ0QnEcyNMWYpEs5AQHPu0UPhFVjDR?=
 =?us-ascii?Q?YJK56X/2QkY4c9BaAkYqbIOlSo7XBaBS5m3LwyFSQeLLfx0bdCtDewvilX3n?=
 =?us-ascii?Q?wk8gZDkUmZxNGKAP8dpj2g85RQGAchhsOT4EqcPTchU3Uz7bbTctgL3xkqlW?=
 =?us-ascii?Q?sX1XgLFqsK2cHNq02SHF285tlUtfjaE3cE5gS7nnhT0kpzjQJaymVyL2x5x+?=
 =?us-ascii?Q?vwrCjqOhT+zLcZW0E+o+dJWPGRosbFUN1Py4EM1pA5QDHvmqt2RQSMqVh7f6?=
 =?us-ascii?Q?02sEnnlawF0+mIea6TVXwtcF6H6X/j1d24A25FZFz10HvU3VZTcCMB8CiQP5?=
 =?us-ascii?Q?r1TN7T/qJoeBYbhjq/csnYGHI6N4zSCQgkp4X7HVWrzwiPObwmVahKPiAltz?=
 =?us-ascii?Q?jTNJVLHbxVuEpZj1bfd4FEYoJOaU4WNIb5s1hXvkvEenWU4VOrddav6aZSQS?=
 =?us-ascii?Q?lXPIt7NZUyMi/NQt?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7oukVcK8Ov8BX5PHoppexs83yvVAlMOYoNKaE2/tiejC/D7RhlM/LSyHLLZ?=
 =?us-ascii?Q?Zh1sZancsbozT/nDCs84eaCKmvkHk7V3wITcxDVsWSg2J4P6wnFcM1iBTL5M?=
 =?us-ascii?Q?/CvvPW8vULw1UGB0EQ27akDYNXRHJ10gbHg3LI96Lsr+D7ndA7RKJHdXR4Ok?=
 =?us-ascii?Q?uxFCsXLfx+dpINyyz8GvskjQtnUpKAUxI0CQI9ICjDzRK3ONf1Rq6s8yGKq5?=
 =?us-ascii?Q?mcr3DzuHQNhOzL0p4S7geslp8cMsk9S/f3/yfKQWjDbyOAXYPH7rwHVJJXUh?=
 =?us-ascii?Q?uqIULP17tuivagu3CrRzR2VSPrb/o3kcDoVr52fibtKhDm83uZ0TZL2sF0b4?=
 =?us-ascii?Q?X84SBQHyegthBjEy43lc13aMwYme/aI89jGa9JrtuCkcJzkQzMcTe4YAm8YK?=
 =?us-ascii?Q?P3YRNBMPojx9DPE8gOPmQUV90x3Jo6ssjRELgMqLIx84e6kpkTxLSB659bfd?=
 =?us-ascii?Q?FtNkCz8H/ZUT8vXnwE/IU4m4Bog0KGVfNrWQAV3vAmo/Jxkb8faep1AqSBVb?=
 =?us-ascii?Q?hkEgOtqVmt37l07y5JNiVTD3wc0yzL3ptjUyiyjaItp1MQbsuXLALV5KXbZX?=
 =?us-ascii?Q?imsXJ93hUozTF1mPQqZJftOpMH+xicnoDQglJ/Np0g4JeLMmNbQAtrIbrBQN?=
 =?us-ascii?Q?DxAeZoAQ9VyWlLa+VKfTny1UQMORRJT9Izu8cGsFjmENICvkWCZsWDsfQGNW?=
 =?us-ascii?Q?MpM5/fs+i41OH7foqlCbpeb5SX9d6mL7qPXB0LMlkS0zgKrL0HREIqepym0Q?=
 =?us-ascii?Q?qkjIeuAXWBDd2FIxj6D09bgzHrYR95ZZWN/oJzYtAXrErUJxIj+SXV9sFD0X?=
 =?us-ascii?Q?BhpKhTun5FFhPBPTIMTf3nAYVU9Gm0Kr3qCyOU90rL7Gj7L8dxhFVsA8ougY?=
 =?us-ascii?Q?rRlwuQ5cll2e2VABGZUea9YWOtaQ5Qr+HwOGe0Uvd6c3VXdGkdvye7T/yQu4?=
 =?us-ascii?Q?RqqTBwAK47sx5M4KHiN9xovHhh2mNCQTWoITkl62GTwLBSZ9ZEfyPhPnYtzv?=
 =?us-ascii?Q?WRSJhz5yvXFgInxPg9dlCtD9JMPQn8fBzvKn27wxfC8ezA6JEuDc7o0TbwI2?=
 =?us-ascii?Q?uw8I5j05FVxShygIt6/rdFpG7dhuIr3+oP0u9P/5Ri1RVvwQX7gx9FQez9Vl?=
 =?us-ascii?Q?+jSML1ORGHoNjxLqHYgkLa/jJF63yVCJay5gle5lwVb3uZgLy3qoAKewAPTj?=
 =?us-ascii?Q?8YMCMmDrdvUWRftSLhNJd2UnwJKwavhAgysaPznvl0vMeaVZd7BSq//Q19YV?=
 =?us-ascii?Q?vtJ0pLlEra3e1HVXKhBmLEQ07jEUghseoi2Bfw0KhcTC6kRmnvc3K/uptA1v?=
 =?us-ascii?Q?PfH7h540opDoaejuIH85dUXYL+o0ZO814LmhD4fOjm7Jh05jGTKQCa0kDqav?=
 =?us-ascii?Q?oCbjyJtNXTP3RwEgzFoBJdfHbWvf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b3ce9f-e1c6-4271-2480-08de7381f076
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13602.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:51:46.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12471
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8156-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangshiji66@outlook.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,OS7PR01MB13602.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 20DF918404B
X-Rspamd-Action: no action

According to the programing guide, mt7628 has generic register layout
like most other hardware revisions. We should not set pwm45_fixup flag
for it.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/pwm/pwm-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 9d2063034..dee61e7ca 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -525,7 +525,7 @@ static const struct pwm_mediatek_of_data mt7623_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.num_pwms = 4,
-	.pwm45_fixup = true,
+	.pwm45_fixup = false,
 	.chanreg_base = 0x10,
 	.chanreg_width = 0x40,
 };
-- 
2.51.0


