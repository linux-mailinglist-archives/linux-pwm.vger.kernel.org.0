Return-Path: <linux-pwm+bounces-8155-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JFOG9BmnWlgPQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8155-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Feb 2026 09:52:32 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4371184026
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Feb 2026 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 067173010275
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Feb 2026 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E4734CFAE;
	Tue, 24 Feb 2026 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fC4tIHfc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011032.outbound.protection.outlook.com [52.103.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41362DC35C;
	Tue, 24 Feb 2026 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923107; cv=fail; b=m5vsHU+rNH3qbHfPimtb9uLOBWC2j/IUh+TjTxoMudABN593pydOQTlpFeu3HcQkuUOX+zCYTvkDqG5B1iZPqoHb1UHUJ4UShEj/gUxCkwF1nfHH+GD/IDnX3smKFsQeu5uM/rU3Y2NHd/3R9K78BWHiPV6G+s3CG3qQarT9CME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923107; c=relaxed/simple;
	bh=DezUTl13Nnj0KR7OzQaErKFsqr3Nqd262YEzi/ZGsJo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GUdMFYz7Xsl7bJ5zmecyKsU798oA+1gXy3hCPK17z48RcSPFFsp4nbM2l2/4wVXiK7kQgbk3ubVhxR4CcIj+qVRAX6i8JbYlZ26OeNP0HQSu0y4MwqujdwibE+pRgMX38JUqymEA4tPg4wq36tT2/87UaLbQECb8kgUy5WuFS5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fC4tIHfc; arc=fail smtp.client-ip=52.103.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsbsRzB1sVJIgR4d6oGLxIVPl3AjqBSoV/7RWlbW6WppeIymqSQ8CXnzJWfHcH6qRVPK2+bZuEwvEdXMpJA8ecTyMuYpmDdWWQE6kYnEOz/mJmzwyze7+0KzGyhcvQmtWW0Bt8KGgghHQfbCavrN8gtnMZKbEqzRzZcZDDNDv4I4Gmp3uJfsg9OUHCMznL0q4Fes+imW7mFIE3JFPO4dIDIsJE+O6H7UXJwkDzo20Rws5/aD+C78M0yzIm7MMuu448iOLQaDE8AYhNiNGFw955ezp6tuuSWLl6eT485BgaSakAFORUSX6EeN1oWvwer5nfnEzRgb2dUDaTwkwFy1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALLbK8KK7OvAoH62xzaGae6rUdJBxFrUUbUvU8LbwGQ=;
 b=XFZhzZGLIuxjAotGzSnUWXR1RFdcI8CzGc5nm3llIE3Q2rpZnh3w/M5LKQGrH4+T51owhwSC5jZCzVu++sUx5lbNhGKK5yWbnQ/obhHJqYZlcSid0KydA9dRCFCf1WzFSsfwErbXAGr4UO1Kp4z5FC4stgQ4dKuEC1yWb9FWPFvLJU/geNmS+jYkEdorID2Q0lkD0daHT8rAW3oN/if1oHQ/BKEU6w3fg1ZMJgBk5eeYAOobrwVJceQCneXQixRX0xbf/Rigk53CaRvmnL1jPSDxNifxlk9hsPkypakPVnw7947p9XeuYlzhAJeYgsL+qymrZdu4SoZoHMcxClBlVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALLbK8KK7OvAoH62xzaGae6rUdJBxFrUUbUvU8LbwGQ=;
 b=fC4tIHfcjI4Lr+A3cPOJp/rA/TQ8w0AVT61xX3dhP91roAzEJS3mdpBQGqkWP9+Zgf2H4ylXgrhXKye+O8fRkIfOkRM50gmWjlkjMNVtpgwHv7FOM+qehpNqA+06RvZkJ3oVt3fh8zXb0cLE2bqiwxc8zFHK4+9sTb0d2CK7DMN9cTBLmyJwI0GVc7ItCs7m5UkgDqKOQwT0t5xCe7fR8c0CnRZTCCRcryV6dXB6pPr5/dGwm+fLF+OTIzOymi1qhnOVeTNU13CHLtZFNL9HuXlzgs6DFlOmzqMvcQU6vVcTrZgAoqaF89Gb9AS49bBYfNxg3BRr83bspKcLOzF4qQ==
Received: from OS7PR01MB13602.jpnprd01.prod.outlook.com (2603:1096:604:359::9)
 by TYYPR01MB12471.jpnprd01.prod.outlook.com (2603:1096:405:19b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:51:42 +0000
Received: from OS7PR01MB13602.jpnprd01.prod.outlook.com
 ([fe80::7a94:8782:9191:8d50]) by OS7PR01MB13602.jpnprd01.prod.outlook.com
 ([fe80::7a94:8782:9191:8d50%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:51:42 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] pwm: mediatek: fix mt7628 register offset and clock source
Date: Tue, 24 Feb 2026 16:51:00 +0800
Message-ID:
 <OS7PR01MB1360282ADC135931ECCAD9AF6BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To OS7PR01MB13602.jpnprd01.prod.outlook.com (2603:1096:604:359::9)
X-Microsoft-Original-Message-ID:
 <20260224085103.18710-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13602:EE_|TYYPR01MB12471:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c38836f-6fa3-4f0d-07f1-08de7381ee5c
X-MS-Exchange-SLBlob-MailProps:
	9IecXKUgicB5Y5xtj3Bi4po1AHQXatGhADt9LhZePGlYccZpLj1Xsybit2NV5zQL6TG/hg4vVlnswoF3zbCEHZ2dcw+3nUplC71ST7H0f1EHLSQIOMjp8Yj32C+J7TS+sFHT4SGGturcjTE5J5pVzDjbCpCnsy6gRcJhwwv1CDicJadW9hDoGq41ZiBDS6iWJ6sbkfIlh85buKTImlOIcCPNckxc4NJzh7kK2R44oSqTPEMe6QxB6mCPSPm5Fe/UgntYlbRskgSv1h78hAQf8YydbpnduAkZn0DVig1eBiwjlNDdridJSglCgtdmEg8zbNBhgsbKfp/x6Du6NsksqK3vsSIg5OiBl0geY8ImWn8lvlJqFuOFCXIRZf7HnLm30pFEFQNH3ERvw7Q2ZBY2xERjy3zYyB1EbcZUWmVUP+KO0Kv9EGhGI77cZ3YUn+lhlbnBFHKPb0tlVK3IanxOmGUj9zdM82WxkvDaeoJYaumAqlovXKnlAOAkB5q4rP3bkrpqOdk52Leq298aGdvVEH4o59QHYQtKQdVpBkJDI4F34AJT3GbBWZvhJ9ptm1Eb3rQdFuw9m1te1WxWh/7hSbNSRANCDLySq4mn1TyLBHpBlCjNjS4nJlrxvnjkljOwrr29HkksxLVQb6gJWmo4ot08YH7aJextjkxJkdMc1KgIr6KisN1290ofCijhqmi9L248vlDokl0Yb4DcH5r5+BFLLVBXrM7tlTSFdF9ECazSWqi9Kc7zIw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|39105399006|5072599009|8060799015|19110799012|23021999003|15080799012|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NZqDRaJjwX8/tOLi6gJyG2MlqxznqV8XdCYhlkzkbjQRDst6O13C3LPUfI3T?=
 =?us-ascii?Q?AO4MbB5jSLD7s33a4MPkVw8yLSWRE5h2nPWgWOwPEksnLkONSsFu3P82YcPa?=
 =?us-ascii?Q?iZv1Kkdb78VErDjGpPYtXeGLczR3pRkUwH2IjIVo4O4iULQkg0nYMT47LzUm?=
 =?us-ascii?Q?cwovcfjwYZ4ofjCKAtXs48txiKQ5aNK6lpC0WdY682396Swa0NYd3qDT5jJG?=
 =?us-ascii?Q?0uSr6P7V6u6Mz726B5HMTon0tXMpKUwA0bCBXUoaRZ5TDu4noDWstV6FAotD?=
 =?us-ascii?Q?/JTujz50KFsxNdcIX8qCJQ3cdrfmEhiF5qfcNY8Hl0r9iEiAaiipxOcx+HrX?=
 =?us-ascii?Q?eZneEjOp3AE6arDJYSE+YNHcwLFkH+QLk25wO81+TcJRavYQsM1iTQadAsE6?=
 =?us-ascii?Q?XVmLb7//CxxSIdiTuvB/PfwNLkb88YknJsrtHouiuVlq1H2z83LXkSx3+tZF?=
 =?us-ascii?Q?X1zMtMfwJ5kj+mPCz49V32A0+Sojeql1qSkY7EGsypiLVOkTUJrxgXt67v1F?=
 =?us-ascii?Q?SjdzbvkpzyKiqiMVZ3YCz9y/XJh7cRyKAxze+81uIirwLFqQPSeaTuxgJDYc?=
 =?us-ascii?Q?ZURB1HsvbUmW5J5S5rqpmY809tN50FgYe5TWdalpAF7pDpJ16kNvdUdPfxMH?=
 =?us-ascii?Q?oXkBNbmy433LQe9WiSdrbxMruem9jwzDse4i94jEmFKZcZ33AWsY+KEXUk1x?=
 =?us-ascii?Q?fY1/Mc63MA6ewu5Z2egMdS5+r8uk6y61+Sm3d87ED7HmCxd4rmvk8I3voW5Q?=
 =?us-ascii?Q?5O/qIH7O0w1zeIcbqgvfssidYj3GBjo83nZSsdBNHaTnG6ycc/SYkRzJUZRs?=
 =?us-ascii?Q?i3zgOGNWsy7vLyDOlA5MYgu/Kv2xgn2S5rq8evNldtQHSojmoXlo2lqWtRMQ?=
 =?us-ascii?Q?7OqR0YwHjktRO7E2Q1xxsz7PNS+ZLbzWGqc0bagxDGordyz0dbFaE4QGuI4w?=
 =?us-ascii?Q?NePcJkP4XLXYqUXbwybc9BDzRvjxrL6vh2nPfl73idbomO1Lfbiwplk1eORx?=
 =?us-ascii?Q?xFGIBAJ/Yk5IuwXI0SqilON1+uSCg/n0AqnZd9cqfX7dqiqc0EAJMfGMO0aJ?=
 =?us-ascii?Q?Gy/6uPePoiu00EIMaUzd9c+cfxeOt+hfHr8v6IqwOdPPO4sNgR6Enn4722dS?=
 =?us-ascii?Q?XXOKTUaj4wtf+jrIdRZ7w2/hX5FbEHPkJjSN3UZmD+bJbVY2ChNohLM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GQ1GJZ1yYooP2AIU6FkQZSC8Rc+gjN8tsjd7aEDaWk29eXe/ZBXdLb13ixy3?=
 =?us-ascii?Q?sAuXn5yg1zjoWSmA7TckuoevdA5IBnzoMVxySvl+8skac6CwfDkc6qgGrhw4?=
 =?us-ascii?Q?EzOsSeyOrMspkaNTwF44XbTwE34mV0REImCi4wIlvy75tb+egtsxfwe2yNWt?=
 =?us-ascii?Q?Hszs877oH6zX/5jenEejGtsoeDWwgzq2EBt7sN7cOKgaI2phz7XltRv+7FZ5?=
 =?us-ascii?Q?i8X4/Hh6ZnUcx0XbeIAEEuH5Egm1BPq4K5nDBKeTbrvzFKQNidEXRSIveuXC?=
 =?us-ascii?Q?kpHlZN630Mq1weLvf91p/NYwrnsEirKBwe8rW+NQFi+NQ2jGend6aOPo1BD5?=
 =?us-ascii?Q?FaY9W3VfX124Inu824plSSbNxwtD0GcmFOik3EhfE3fPbmYSm9aTAqwKEB41?=
 =?us-ascii?Q?rW3sh0nfF04dpjuCXTkPhmNL/ftLC8YzDHV7Wgf6pvCiiViiOj6zfCzlB+3r?=
 =?us-ascii?Q?U5om8xj6X5DyCgu62r5mSrRTI4Y0gg8+JV5RS+Dqy27hnwBe/ibWKqZdOJpp?=
 =?us-ascii?Q?igGYtoFNSipKg14rV4SdYvDve0dDhVptuuTiNnbQKpoMbQ9bKWDQQtCGwzAk?=
 =?us-ascii?Q?YSDg5BRtymMh0WgCyGBWTuUtakdg0i9RaCEQwarChb0vDahNt1rpIu4pLZ1r?=
 =?us-ascii?Q?rVMCNKwxQ2NcONV+GWO8itAOdtDgkJWoDLASOh+hRTF0yn4DQ1VmpJ3rg298?=
 =?us-ascii?Q?CUIMHODxexwHNZOvp9l/8udJO2YFwTW2b3GJ7NJywzBWkM4iMweIGJLf737I?=
 =?us-ascii?Q?ioxx7CvkIN65mMfwtlvVr6dFpHg+95z/6YacZ/ezajL4hVDM25KQkSKjJJZd?=
 =?us-ascii?Q?kMfiOqr2z6MJJLxuE9SgeuTTdaPJIqqKTWgTLDuXgdw3z6+6fLRz74xVQznF?=
 =?us-ascii?Q?2VDCXqll2rRufqH4Jzjs8SrnzMXIIPAHadiHDLrr+zrGQNwT4CJyq+3Jxq4w?=
 =?us-ascii?Q?ZxG3k4BS0rM7ybzhMCDXu7GdMvE5soLNrw+RQ7FT8UazBCl8NaDueRkkpOSa?=
 =?us-ascii?Q?gS/pNrEBepJUb9qfpyqY38C5GmNLwW4YsKcXdIW4rT0HIpdzcGk2u6A58tHU?=
 =?us-ascii?Q?iRcjnjJlHVHt4ArlCUMi4m9GUoFZ2EGjf2YJUrUsDQTz0IUvgZRRT/v3Gqqc?=
 =?us-ascii?Q?Jz3FBcddw3qyifksG4x6CyHDXb8dhRRGrWqPVXa9Tn834mqF5cDMU5Nzptc3?=
 =?us-ascii?Q?Z2IwT50XyOOGqnngnW12E388Dix2QUPKY3c8Q4fQj+9FV5lV9hZaUrdA9tH3?=
 =?us-ascii?Q?S4PcEp5k9Yl27jxOcsY2bt3oEqvUcEPZAPVCC6VMSPvUr1aHOUqQMYhTx1P0?=
 =?us-ascii?Q?lJe+V8b3N1nJ/6iC77Adv6j/1/XirJ1Tq3XB429ukyT80l+0ifHAu9ThWuVx?=
 =?us-ascii?Q?9WxrbAhMPpYHKji1d4tCrhOrxNMi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c38836f-6fa3-4f0d-07f1-08de7381ee5c
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13602.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:51:42.5110
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8155-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,OS7PR01MB13602.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E4371184026
X-Rspamd-Action: no action

This patch series fixes support for mt7628.

Shiji Yang (2):
  pwm: mediatek: set mt7628 pwm45_fixup flag to false
  pwm: mediatek: correct mt7628 clock source setting

 drivers/pwm/pwm-mediatek.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

-- 
2.51.0


