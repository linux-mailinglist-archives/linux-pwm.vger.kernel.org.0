Return-Path: <linux-pwm+bounces-8157-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCHTOehmnWlgPQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8157-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Feb 2026 09:52:56 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4530A184044
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Feb 2026 09:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CF3430197FC
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Feb 2026 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3257369224;
	Tue, 24 Feb 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MjukWM07"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010018.outbound.protection.outlook.com [52.103.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B736829D;
	Tue, 24 Feb 2026 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923113; cv=fail; b=Ir9ydHy+jvCEcbYpR/bVLgEwnHmR9xwzlbJlYd4R9RVTjzjCtfzervhLYD2czj2qE7L8/gc19ezHDB4i/sO2lmgVcVKOSMt5vK5q0u84ksOnizZN6seea05e6vyUIdqYpkKXUdT+gOQxIOa7ERCR0oMKnZwCFw0o+gRutwzeowE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923113; c=relaxed/simple;
	bh=JtNKbGXG3CvnZBp4lI3WiKcmjuA6Hf+pzPkevq0Hht4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6+1yD+eoRkf1gunOSrH48ocuQLfyN0J63vOCjmxeezM8tbYe7ShoWoQJSoSmE7+ttl/UiUi6cC81C2emMWyS/kzzYM0htUdpMaw6y7Lm0cKI5VU8D+LUkPvJ4slUyQWKYvB5JWFQEjJuHRDZlmRSi88n7U13TVKco6tbDWUWA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MjukWM07; arc=fail smtp.client-ip=52.103.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzTr1RO1OsrLWfiL/gmgk2V08FtDPd5wLyxYKlAHlJjNFtpoX0Zw6cBoF/XycwMDyKiv2BKM8xziOoZOs83rbS+WbetCZzjixsGuwqw41iwdiQQgmHmtc3GAMxDby5Nxi3ldszvb4GUnVgMbWFS3PTEVG97y3x/SdbyBMtYfBdtTBdNbSFIBkJFphtY7gHj238kSkb2S/vUFyRyA+8r8R6hWr6AzcGRNCzdbKyc3TYYKzvFdCH1VGuhN3n2d7YnsSQY+sc6pCTCVUJVNO3K6Cy+E1D4FR8lvrB1kT49+w72FxufwfCauNgt0Lz39a2sFb9NDbrBXnMCt/4Zxfckx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTF0BGbbDPX/m/Z3csdj6OSKuHDE7Hif+gJSVmbu2EY=;
 b=lkzbtpFRHIfCHB6bEPRN6FGW/9emPvLHLuiqvOn80Z0mZiUE/uddwCBtDPZoHpYOLeOgCzwOwkegYeEKPQCor+dvs8V1J0/rbjLATTRPLKV7dB255XPa/REL2y/61l7gUQozyallFAiO4pHbM4uMfrTxdtZ5MPGP7VuDpckXJbWV3Wn2sku497O8KkXKcCJVoZieASyftRFUOwAVXdiirF5UthBGlw9E1fwX9LYMlxPjMFS6L1IeqiJd7v+VYMsZRDSQpe8TOs2gPW0wo80Ri7mHAJThDtUTbftkqm2tkt257YtVyArjjPLeFeYqGtNTPWRD9bTDFIhQmjbYMQIxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTF0BGbbDPX/m/Z3csdj6OSKuHDE7Hif+gJSVmbu2EY=;
 b=MjukWM07OY3+VHyWdUQRhVAIwdOOlGVaielTq+xyhZYh5bo1nlgJS45rzrK3pGDyQ54lqdJKddAIW17bFTIgam4uKzCULPB1pYINQCwmZvxSpNyLGT5zNYmvS6rHav5gLfTCufGBg9Cfp7M3zLmDz09W1bSJW4kIyxmMJ0/GaV+C7TJB3ZjDO5uDKQ0dl3Lxq4KYvuysRQn0WWlL7gQkXfVkNR8uEMhcg7mHPqj+j2j3tiAs+xWDQibnbY8vJHJw/u3uIrHN+oelCY6ebzQWEDarvj3JExkk7GHFiFtGGi+cLkFJ0SEKcCvOmrm8KI6bO0I4+luqCwrYvjiqaIIqlQ==
Received: from OS7PR01MB13602.jpnprd01.prod.outlook.com (2603:1096:604:359::9)
 by TYYPR01MB12471.jpnprd01.prod.outlook.com (2603:1096:405:19b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:51:49 +0000
Received: from OS7PR01MB13602.jpnprd01.prod.outlook.com
 ([fe80::7a94:8782:9191:8d50]) by OS7PR01MB13602.jpnprd01.prod.outlook.com
 ([fe80::7a94:8782:9191:8d50%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:51:49 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] pwm: mediatek: correct mt7628 clock source setting
Date: Tue, 24 Feb 2026 16:51:02 +0800
Message-ID:
 <OS7PR01MB136020DA816E8D601D5BA8BF4BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <OS7PR01MB1360282ADC135931ECCAD9AF6BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
References: <OS7PR01MB1360282ADC135931ECCAD9AF6BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To OS7PR01MB13602.jpnprd01.prod.outlook.com (2603:1096:604:359::9)
X-Microsoft-Original-Message-ID:
 <20260224085103.18710-3-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13602:EE_|TYYPR01MB12471:EE_
X-MS-Office365-Filtering-Correlation-Id: c485a3f0-80d6-4c41-d818-08de7381f2c2
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0pc9YDbL9Gmi5v/r8kV+5pop6NkYzkDv+JLEBukP2fZrbTUZKKkt2lC/dBLe9RKMeWq7B6vnOZ9UygOCJuun0h2PsF5wumuwwiutUXdXnQkFlz07s3kzSrd3l/QHtX2BwfO/GGJ5j+gpFDfcpaqYFr2ZNKGVlnVhPynHSPyG/Yo6E6K2OFEdzj1LprZjJcnAArMOaLb39TylU4GFHnGVCncbSkmFI89SA5xqwxUyq2IaMZLTlDbLkQYw+Su0fUxY+wVVNHn366SuNLLL/W4xzNYAceg6sYwWgBNn7XKC+bm2IfdOi38GPMGyx3JfR/ojzrmwDXd1Obt5gQYkdgavF7whjPBKbjU7k/vBZqf4rpBlTKie7OPZHrH2eR9Tdj9LqndW2bVIia5GJZLqZds7UUvpZYLsCTy22VZgEKSEGxTv8GeK1FkGwZgg5oReiI6pUHhS15BnP1ruVDm/n7C1E/V26XNCAgECZsldQ5bTs6NMp4oCzn4HKg+W7+KCiYKsblJM6L0oejwbnZup0CUQVPbN+zkHjJXzI6vHWzKMa4z3dAXWuSyGKAGbJnqFKYq0IwFYOQrqO85FPAdCCJbqaeCePsBP1hcxdRcWbgHkISsX6BPjPoUG3a70JQPVVIzfBMrkLaXG4feo53whDH9uifrvlKlRMbvCUv3Iwhbxu1HTxQPQ6VA4YMnOsBCM/+2rqR8fyF33PLmaEwC7IhQSlwSyqd0J5Jh/DlThb4D5cSJs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799015|19110799012|23021999003|15080799012|40105399003|53005399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBKYhN9yc1QJ+0gnxaToxWkEQ6Ru2MIg71eZPqUjuLtte8zs07FwIl6poslV?=
 =?us-ascii?Q?VulLTZ+3D2O77+pCylolc7Clg8JwnLgthJ8KWQmO+uS9mOD4mKyWct69w9sC?=
 =?us-ascii?Q?z6LxIWPggGCHua6QC8BFV7MuunoCvwSJnx2pof90Y0WRZl9nm/4HBWJ+xm6h?=
 =?us-ascii?Q?0cRxmS6Tbb39ie9GRJ8FgaEZBQFYWIrX5cmdCs7yukN4oqaf5c1+KIiVCWnl?=
 =?us-ascii?Q?ycJ51fg2Evg3X94XjDUaUGvWkYDkpzJeaidv5IOWLCYW88iSX1EErwehq+5q?=
 =?us-ascii?Q?mv9E1rNqiHhj4FUzWfEiaPPneR6ZSeW8qXBl2jm6jWqISWiTlu9a9zS/+Ta5?=
 =?us-ascii?Q?DPaGxgp397+D019gx6WDxUYzXIme3r+5T5dAyuSRiwv4aFhWMOZicBz+RWiT?=
 =?us-ascii?Q?u/7hX8rb9uh+nry1HgTKhfl9aF0ClFiUr3jISe0QmE7wPxsx2M3VlQCZ2x6g?=
 =?us-ascii?Q?e4RSFMF7tDQQ+dPRMtoOWIr5Jxbrl5JUzfVC1hPXO9Rly1C7o7Ybg9r6HU3K?=
 =?us-ascii?Q?uOQBUsVuA7zhnzy9NyPgHn9x4fTL6+r0CE7G2A4nnLTG3HpHkkG989/PT9dP?=
 =?us-ascii?Q?nzJFyTv5DKiYVtFyF/a76/mhW9vDns+9xO3MNEdAuFplIw5GwwMj9qge9Nt1?=
 =?us-ascii?Q?74OOruqOwSs1VSZfhbcQ8xZfIL6JWL6Fs/g98Ur1PHWNQazA5R73fzFsZvvs?=
 =?us-ascii?Q?ObrbQqTzsYPgogwhIDp30o0F8dK+IzTNQ60nUq1V2d4n/L7IsYV9KMQEGzHf?=
 =?us-ascii?Q?H0K5pKEFCDDrjh14UiXEoSHgruufW5TS9M0PNuQUevO3ZWhOSKD/j2+imtRA?=
 =?us-ascii?Q?BnGFV78igpezLdgacX15xN01/x74DrJRsd9eOluCr56hu2XRAcpciQnXsPJJ?=
 =?us-ascii?Q?4tF0MuknyzlPKhY0X02urI4qM8/KsXwPUU96AHCeu4HoZmQjbS/r52SJOUrC?=
 =?us-ascii?Q?zc49fM4OM+SEbzbCOHVpfbM0j6NU6JULJ77+qXS24ZkwBbIgX7UmmzQPgBGH?=
 =?us-ascii?Q?AnHVIW9zYqWf/dluaq7KBWZW6RstZyp8CDqO/XZmh3lqwh7CeyGstvZ5CdMd?=
 =?us-ascii?Q?eXrpYGe+LtnuA/Qj19rCR1CxM/Twjwc1vX+XEr3uoLF7xl3zuf0+E4cFPYVW?=
 =?us-ascii?Q?gI3igc9izofegmw/Kb0nFJVZp864r0L7EjHr6YZaRChjXh3qUd3HzJuHIzB0?=
 =?us-ascii?Q?j+2HCv3UNiXPh/Gs?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HzpinXx8EL2L71v0VMwFeuQH2Z35V8vMLRXxjHw//LiWAuC31W4LO5S2qZqS?=
 =?us-ascii?Q?BCEJfTgQKVoKsdbNbYV7B+33s4ImGMwpvjhQKU+a+JU0q+xiYiqMsIbhnxB8?=
 =?us-ascii?Q?uoxHQI7fEeX6eSmLIOw4Bk0JY6jINVIjozgDLClf89AvLdsX/uX20pMyTqb0?=
 =?us-ascii?Q?urfxyCjbZqnRzAaXmcVHQxiO+JIVyUmw9/1kpSj41CPlmeqyMj9pI0aYCkiB?=
 =?us-ascii?Q?/0FX3SutvEUY1uBYmVXYbduOML4UIZo4/DgkT+v2VNoHfaalIsGLoApVfk/M?=
 =?us-ascii?Q?wdn3kF4c4eSMOIVqzwasIA7TsdUXTT7r9JtMO/Z9XNdrfHyBAmeGBJ6xHgGJ?=
 =?us-ascii?Q?4jxxOeBhDvOUtt11K1v4uV4w6uVS7uFkrFHIlKabYih7U1f7QE+42SCYWI4c?=
 =?us-ascii?Q?YGI0WxUgH5wZgVWMqxwf4RYpJ57s7lo4RmH/YPP5oJ1dJL/0I7p5LC9ex9Ur?=
 =?us-ascii?Q?nPuMPoUF40vdtQ14TiMcPBw6MyUW90ahlfI238zzKUXdvw6btneIBGMgB8bb?=
 =?us-ascii?Q?n1MtTqiRVhz+EVuM+GTgTSWyN9QC/qyr+MBYlhO09lcqw1CQB6GIiyxW+Tdy?=
 =?us-ascii?Q?J6QFLL7J+k9Q3rJua+fNQNE8j3B8UWfQdUzwjj16bIA6L3uSvYGytal2fs/l?=
 =?us-ascii?Q?Lnxtiht8pcQ/3FCcfEMI2i4qY4H7T6HAYtaF2Kevk+qm9IScLfd/bML+aQL4?=
 =?us-ascii?Q?im6Xzj12SU8VC7e5sYn50tc3RE0afE5ebj2FWxFMxd/vPx0E1qNBaUWA0M8t?=
 =?us-ascii?Q?ojbhyJYv8BKejnpPo8ktGSlN8BTPLyIHaXQkfEuri0rttt3KVPiACldqJxc4?=
 =?us-ascii?Q?qHMcFllJO5Ui6ixJYOqDV8izQ4DSNniMaLqdX4JFFe1ro2NQQjVn+eEWJatA?=
 =?us-ascii?Q?HLB/dTGn0gtuONiqTtYea+0I3OhVTxiF4isuxHsAAYSiuAjz4yOyKFW2ZDCl?=
 =?us-ascii?Q?XAjGTqqC8K2EHVyaugC7GUxXcZsmmZTknYPzCc/UZTR8eGWEA9B1TNsKtudv?=
 =?us-ascii?Q?TYuRGPORmiQX23ePcNY0zckxn2bJUP5irOakXggsXV42R/1mZW5lIpUMCtP0?=
 =?us-ascii?Q?RRH2y8AqgoPJe6h3Hig69zOaHiB5g6QapNCF+fimoIOCCSdc4tTr2rux6DcB?=
 =?us-ascii?Q?1R5LNsEe/OcU0S2wFIzezAkKokUaSYpE2xqvDlH6WdQHUomwUQ0aaWRwcGuH?=
 =?us-ascii?Q?oAA4XJsyznLEO5tv1ffpBj1WSOHSrv35uHZDYTdGZI/XwUpyIYlWfvm+UkGM?=
 =?us-ascii?Q?0oH0leJbbHUCN7mYIvC7O7Iq74FASzGHIVhnJJxajVue+39dyBlw724sMByY?=
 =?us-ascii?Q?VZTJW+d/4B0e4b1wYevOblJKw47COBG2VhR6fkBOTRZAc3f8MVd1ca6H/hn6?=
 =?us-ascii?Q?eeFCFcf1V37WJJYvJJeVN10/0dnl?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c485a3f0-80d6-4c41-d818-08de7381f2c2
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13602.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:51:49.5842
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8157-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,OS7PR01MB13602.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 4530A184044
X-Rspamd-Action: no action

PWMCON register Bit(3) is used to configure whether to pre divide
the clock source. Most revisions clear this bit to disable frequency
division. However, mt7628 needs to set this bit. Hence, we introduce
a new clksel_fixup flag to correctly configure the clock source for
mt7628.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/pwm/pwm-mediatek.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index dee61e7ca..992137a27 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -23,6 +23,8 @@
 /* PWM registers and bits definitions */
 #define PWMCON			0x00
 #define PWMCON_CLKDIV			GENMASK(2, 0)
+#define PWMCON_CLKSEL			BIT(3)
+#define PWMCON_OLD_PWM_MODE		BIT(15)
 #define PWMHDUR			0x04
 #define PWMLDUR			0x08
 #define PWMGDUR			0x0c
@@ -38,6 +40,7 @@
 
 struct pwm_mediatek_of_data {
 	unsigned int num_pwms;
+	bool clksel_fixup;
 	bool pwm45_fixup;
 	u16 pwm_ck_26m_sel_reg;
 	unsigned int chanreg_base;
@@ -337,6 +340,7 @@ static int pwm_mediatek_write_waveform(struct pwm_chip *chip,
 
 	if (wfhw->enable) {
 		u32 reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
+		u32 con_val = PWMCON_OLD_PWM_MODE | wfhw->con;
 
 		if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
 			/*
@@ -364,7 +368,11 @@ static int pwm_mediatek_write_waveform(struct pwm_chip *chip,
 		if (pc->soc->pwm_ck_26m_sel_reg)
 			writel(0, pc->regs + pc->soc->pwm_ck_26m_sel_reg);
 
-		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | wfhw->con);
+		/* Set BIT(3) to disable clock division */
+		if (pc->soc->clksel_fixup)
+			con_val |= PWMCON_CLKSEL;
+
+		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, con_val);
 		pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, wfhw->width);
 		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, wfhw->thres);
 	} else {
@@ -496,6 +504,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 
 static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.num_pwms = 8,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.chanreg_base = 0x10,
 	.chanreg_width = 0x40,
@@ -503,6 +512,7 @@ static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt6795_pwm_data = {
 	.num_pwms = 7,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.chanreg_base = 0x10,
 	.chanreg_width = 0x40,
@@ -510,6 +520,7 @@ static const struct pwm_mediatek_of_data mt6795_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.num_pwms = 6,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.chanreg_base = 0x10,
@@ -518,6 +529,7 @@ static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt7623_pwm_data = {
 	.num_pwms = 5,
+	.clksel_fixup = false,
 	.pwm45_fixup = true,
 	.chanreg_base = 0x10,
 	.chanreg_width = 0x40,
@@ -525,6 +537,7 @@ static const struct pwm_mediatek_of_data mt7623_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.num_pwms = 4,
+	.clksel_fixup = true,
 	.pwm45_fixup = false,
 	.chanreg_base = 0x10,
 	.chanreg_width = 0x40,
@@ -532,6 +545,7 @@ static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt7629_pwm_data = {
 	.num_pwms = 1,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.chanreg_base = 0x10,
 	.chanreg_width = 0x40,
@@ -539,6 +553,7 @@ static const struct pwm_mediatek_of_data mt7629_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt7981_pwm_data = {
 	.num_pwms = 3,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.chanreg_base = 0x80,
@@ -547,6 +562,7 @@ static const struct pwm_mediatek_of_data mt7981_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt7986_pwm_data = {
 	.num_pwms = 2,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.chanreg_base = 0x10,
@@ -555,6 +571,7 @@ static const struct pwm_mediatek_of_data mt7986_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt7988_pwm_data = {
 	.num_pwms = 8,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.chanreg_base = 0x80,
 	.chanreg_width = 0x40,
@@ -562,6 +579,7 @@ static const struct pwm_mediatek_of_data mt7988_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt8183_pwm_data = {
 	.num_pwms = 4,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.chanreg_base = 0x10,
@@ -570,6 +588,7 @@ static const struct pwm_mediatek_of_data mt8183_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt8365_pwm_data = {
 	.num_pwms = 3,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.chanreg_base = 0x10,
@@ -578,6 +597,7 @@ static const struct pwm_mediatek_of_data mt8365_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 	.num_pwms = 5,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.chanreg_base = 0x10,
@@ -586,6 +606,7 @@ static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 
 static const struct pwm_mediatek_of_data mt6991_pwm_data = {
 	.num_pwms = 4,
+	.clksel_fixup = false,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL_V3,
 	.chanreg_base = 0x100,
-- 
2.51.0


