Return-Path: <linux-pwm+bounces-7750-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E6C981D6
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Dec 2025 16:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246503A35C2
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Dec 2025 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6126A3328FB;
	Mon,  1 Dec 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="S4I5YKeZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010006.outbound.protection.outlook.com [52.101.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73E30AACB;
	Mon,  1 Dec 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604281; cv=fail; b=WV+bz6xl5UNTbvOYnGEexedBsfnei11VdQErXRl8UMVA5WCKF1GKcsoWYc7KadRmlPJLlRJc6rcIB7T9ieW9t/BsNoZuJcnxiLtzQSI/jKGWptH34mpiSSwdMF23Ynd5jtP9O2ge80M8vbGMryLkR9gYW0Asd/6XNN7Gxd8oC50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604281; c=relaxed/simple;
	bh=x4w8a9aA1rGo08osAnVwvF64cOkte6zsdYR8HNWDaAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IXF311Bd6nLI42YcFX5Z/CYH5EHcM/r1A1rHP0MQFcmtzxINgl6NcfAM1/+RJLw+fatdkzvMgJWWDBzD+IEy2uf8awb0gTwr93QevHsXDUB0ajyLzQSqWgfCA+Z4MwI3tpmuqk2OcnIsNh6nfXI7ii/nIZPxSQv+pU2Cb+0njkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=S4I5YKeZ; arc=fail smtp.client-ip=52.101.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPGJ2Q6Un9LPEDkiTM6l8VHE9bHQzqAY4vM2L3xIZPwrabNgg2Te/BtKNFl6GWlHwurr2rT7IMLVy4TBvBm/rnX9MjYEetIGQMmJEkehD193x3F1lJCjgGDLBfYFojyp5xjghcyYcYNM965mQ18WXi9lvWJxcmn+LHX+SV7hOFTaeVlDS0X1JgcqjTHwxet54M8XevbH+xxWDo1/C0gS4uk+uFPxsM8U+uOm+bnVXQ0FsaRnv6+wWE3h0b/tOwDLio7zp7kYqdrzpdLwC9FcnaKGYDF/tbv5n0YxYTmDjdZe5fvDxP4KgXjb3EGhpKER23kQqebwLFA/4L6aVXVn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4w8a9aA1rGo08osAnVwvF64cOkte6zsdYR8HNWDaAg=;
 b=jaEhF6xo6Y3/vu/HCEbi3WlrdeqDtr6fpf//MNdLxNGILDW0oZM+HYD/Qb60/xv1TuMwOYGrSOHVhiDI2UOwO7+NYp6HoWe+9Oipsczlrpa+knQ3WLHFKDS9cnxrXRbE+EErA9tCK8XkHmBV/l0zaPu5VwbYQCDcjyNAP9bEZZ70jVtH/M5K7oo5jjFsM4qUv1wXIr+1/DTvfBbPvsn/q9RzuaIshJsvRIsMj7jlqC1bKzQqfqu3ZkhXa97H1fbMXLQSB6smRYXiUju/FRVOEIvaRgsImovvBBMudv1+mYOaCSrTxiqWwmfUmSH8C736IEoAGNSxLQgB84rgzFQnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4w8a9aA1rGo08osAnVwvF64cOkte6zsdYR8HNWDaAg=;
 b=S4I5YKeZg0Dh1jxpboTLWdowyYBOIR1kmNrWQkeQRJNA8tw8VDKBUVYrc34A3F5n3voAlV+DW8eblRV2QSmPRXS8qf/SKrKWkzCiBHnk46VF/zSCQpzqmzVeZQDKRHvenaEqT1DLdGuWrRarQjbsf0F86ktk/fTvL3izgMZneRg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9750.jpnprd01.prod.outlook.com (2603:1096:400:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 15:51:15 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 15:51:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 0/8] Add RZ/G3E GPT support
Thread-Topic: [PATCH v3 0/8] Add RZ/G3E GPT support
Thread-Index: AQHcLJi3nBegrR4LWkun70YnsuXN4LUNUv4AgAAAToA=
Date: Mon, 1 Dec 2025 15:51:15 +0000
Message-ID:
 <TY3PR01MB11346A70ADEDB2367AA93433086DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <vbqsrlqyzd2hhg3qhbpuw4h3tfigpf5vv5yfqoxyad7b5657sy@4opkalytc3kv>
In-Reply-To: <vbqsrlqyzd2hhg3qhbpuw4h3tfigpf5vv5yfqoxyad7b5657sy@4opkalytc3kv>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9750:EE_
x-ms-office365-filtering-correlation-id: 108fd9ae-7038-41a3-e6c5-08de30f175ce
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlVWU3BkY2x1ZU84NVFrcDM5WjU1aFE4RUFIL2dDQmQ4V201T09iOU44QkdE?=
 =?utf-8?B?V1hRenRWZ1g4SDMwRmFHL05kUzV6NEtvclRvRUhUWGVnTVE2QjI0eWUwSktR?=
 =?utf-8?B?SGRmdFZJeE5RVHlwQXJlOHh2RWlJZ1hpRDJMVm9CRVMyeE1IY3BUdThjSVI3?=
 =?utf-8?B?aG52cVZwakF4V01EV3p4aC9CTEFVbXBUa0JMN3ZtcGNMS09vck5ZaWFiYVBi?=
 =?utf-8?B?ZGFDYkx6anpqQk8zTDMzVHE5TXNQdzhQVEtML0h5RzJ4OWRXOWE3TDUwWkYy?=
 =?utf-8?B?T3A1NGZNZ3RLa2txRnM3b1RnTDNJVk9ieWVtUDlnOGdSZ2Ftem8yTklVbjAx?=
 =?utf-8?B?dHJCVXBqb2l1MkREMmhDVUJ4bWVqcTNka1VXVEY3ZVRvNkdjMVl4Nmh6MUtT?=
 =?utf-8?B?UWdDdmc4b0pzSmUrT3dlRUhDY1JnQU9ZOERmcDJ2SGF1ZklHTjNhendhVDg3?=
 =?utf-8?B?cDRjKzNhM2R2NkpNTHNGNTVnNGZjRElSbHZXSk5tai84SVA2RkdTMW8xRVZI?=
 =?utf-8?B?M1RCWk9wRXM5Q3o1Y2xGeGg0WmVCcVZKUlExTWpJb1lWSnJhbEJSalNqaGRO?=
 =?utf-8?B?WTdFRkFEY0JCa0c3VDhOclNmL0N1bDdnaHRsSXBMcVdHZ2JoeDVIZE9GOW51?=
 =?utf-8?B?MytjaG54K0NFSjJTK1QyRGtwc1VGTVhWMjF3ekJ1WXBLWXA1UWxmT3ZyVmlW?=
 =?utf-8?B?UXloL0pBbmNIVFh6TURvQXFmOWZMNUwyS2Vhd0FmblJ1ckVVSU5CbldKNlpj?=
 =?utf-8?B?VFZpTGZ4Nk5rSXB6eFBFQVRmTVVYMmIxRjZKUjhYckw5YVVWZWtaZ08wTEJF?=
 =?utf-8?B?U3JRMDNoVVZnM2gzellDcDcxRXVTOTI0c2hDTytEZ094dU1TeUFONCtLUmVI?=
 =?utf-8?B?a2h0V0laWXJnQ2lySGNKdDArQUd5Zk9kNlhUUFdSL0xVT0g1YVhNZ3p5aUd1?=
 =?utf-8?B?eUQ0V0pXTkhIOXdtVG9OS3p2dmN0V081UkptckFtSW1vUE10OTFMb0JGTkFa?=
 =?utf-8?B?dWJqNm5WK3VJanVsRmUxR3puQTgwQVN0TnB1bnE5UkZ0QUNYQ0lOSlRjVnpY?=
 =?utf-8?B?dW9VNFV2akN4QlpEY1ErWEhyWnd0NXBQc01ueVVyUFhNWjIwUEQrcVlKZExt?=
 =?utf-8?B?d2QvSVhRWXFISFcxbE9LdHJObmVoaWIybDRrSXRCMXhhOTBXZ055TzBwMVdi?=
 =?utf-8?B?MjhIWndRMjM2N00waVFHODRrcWNFcy9nV251WEFYdEVJWE9vQlJ5TlJXNUcy?=
 =?utf-8?B?K3RxUkVFVzR5YjB5MDdzblpMWW01WVNMZTF5WmxtMGNwM2VVVTQrOGYxb3Yy?=
 =?utf-8?B?K3FFVUN1OVVGdTNKYU9QMlFZUXAwTndKSTJ0c0hqZ2QvbVVhT20vcmhnUDQv?=
 =?utf-8?B?aTV6VFRWSCtXaWx3a3NZKzBPcU5XVEFDRDlmM0plRmNwTjhhZnNyaTl2NUdr?=
 =?utf-8?B?SkNzU2NTb0ZmZU0xNXpiUk91TytNOVpzRkNZemkyVnpiMnJQTll0R3Nzdi9o?=
 =?utf-8?B?NTMzbjQxb0tiTHhsVFpJOVM0YTc4elljOGFOWklWTWtFOFg5QlhWN01nTUk3?=
 =?utf-8?B?a0kyYVdXVGpEVVQybjNDN085aTFTTitTUTQ2Z3JVQ0N3bWF4Q2doRGJqOCtX?=
 =?utf-8?B?b0pidjNaL21SMlRKTjFFZ3FtODI2NElxUHZ4VmFONVBTSWY0dUVxYXpKa1Jq?=
 =?utf-8?B?TWpZSE96YzVUZU00eHZ3c2o1aEtYVlgwa0QvNEp1djV6MzUxRUpzUWZaZFpz?=
 =?utf-8?B?OFdjTXg4Tkh3QUdJMTBrWDJYMWZ3d1Z2eEdvZGJ3eHpjalBGRHZQK094NExH?=
 =?utf-8?B?ZUdneDc0VUpqaUdZZXZhNGxEb3BOdUMweEpkbm00RzBtdFFJbWJqM0NvVGg0?=
 =?utf-8?B?MnhzbVF2dFZwSVFuOWEzY3pCSVQwbU9FNDVFVUlUUUc3NjZHQVkyODJ3MXNk?=
 =?utf-8?B?MUhyUGJ1WDhTWUVGdW4wQnBKMERkcXpEVXlhTW84eGltMHY3TjA3VEdFR1hE?=
 =?utf-8?B?UlNjaU1QWFd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QURMYlFqTXM5U0tGQmdJZUJIT1lXRGZwT1FFY1VPUlpPSGUyU2NOTGtiNlZY?=
 =?utf-8?B?MGVBRjhiSElNNCs4NjB6NUt3bHJYUmJtSm9kUnUyaEJDS01MTUhJZlp5SWlv?=
 =?utf-8?B?VlZoL3BXV3B1Yzc2bmZ0TnYxbFMwekFyajFBVGpaMTR6YlEvbVZJWmN2bGRk?=
 =?utf-8?B?c21wZkx4bit1V055c0lrUlRnYng5ZkZNSUVxYWxaekFRZWFua3RhNjE4OFlI?=
 =?utf-8?B?QWFid2J2anBObU91bi9HRndaV0pRL1phL1V4M0tvYm5MUGEyVGxkYnBvUGth?=
 =?utf-8?B?Vm4xa1IxOTJyTVc5L2s5VElpcFJ1V3l3Y0xNci9LRGp6VDUyV3BCQzUyZXZ5?=
 =?utf-8?B?YXByUFdSVkNDWEc1WkJGcDJMR2o2eWdRb2MrcVVrMHprbzQ4cXdoZThjRlN5?=
 =?utf-8?B?enBuUnpuWS9jdlFFa1dBMURWcTVFTlpqUGJtZUxEeHp3eWpRczFrSFBINVJF?=
 =?utf-8?B?LzZVd0ZBTlRXZ1NaY2VnNU50dDhPemN6Nys5dzVyNDJ1L3BzaFhaeDVCckZF?=
 =?utf-8?B?QXpMazZZSlB2V1lEclZOcU1sbGlKZTcvQnlyN0tHM2UwMEYvVFhYM09YN01R?=
 =?utf-8?B?R1NObTFWMHZmeXcxOGp2SlJnWEtUK3N3WW9RQjYxR1JyZkI0WGpLbzVuTGRM?=
 =?utf-8?B?VlNOV2FHaEZmaWV5aW42NzUzdUZyN2J1QkMxZUppYUtsQjJIdkV2cWp2cU1t?=
 =?utf-8?B?b1h5R2JFajN0ejFtaFNFN3RoZjVjaGlLNjVFUjZxK3dXcCtYalV4V3BtVldJ?=
 =?utf-8?B?SGtET1I3bndGTmdKTktxNnk1SmJrVTJIbjNZbUZyREJJTWhPeml3SzE0bUd5?=
 =?utf-8?B?RXNVN3V0cnZXK3NHR2lqWGkxNS8xVTJ4anZVVTNjT3hIeG5mZ2lTbVYxdHNw?=
 =?utf-8?B?OFk5cm5BOHhYY0Jqa2VSeklCTjc1UE9ranRCWEpXci9ZWmtJM3FRbmd0MHhw?=
 =?utf-8?B?aDU0WnZiRFRubjdxNytLTVlpaVA3SlZ4ZmZNZHA3cXd1MWlHUElrdlBpaFJY?=
 =?utf-8?B?MVR2VURKUHA3ZTBncXpVNzRoa3ZBbml2V2hnRkpiU0gzb05uQjBOWHRiam00?=
 =?utf-8?B?RmNSV2RweE9RdGtzeEJlVkZzekY3TDZES1M1allIbjh0T1ZTSmpPdjVZNTJM?=
 =?utf-8?B?L3JzektoUnhYYjRuK2ErOGNDT1FhSlYram9OR1o1WFVXYTBXZXZiU3BuREhL?=
 =?utf-8?B?SG5CL05OSjhjV29oZmE4c09Id2U0N1Q1RG51ZzNMVmVTMktmbHFQeVlGWVNQ?=
 =?utf-8?B?L2VYTXhDNTBEMWJLaEJUc0EwUGFPSm9XWFdOeXVzbkJVcDdTd1AraEtlZTBU?=
 =?utf-8?B?SUFQTzBuZ3Z0bVR5ckUxWjN0a2hGUG43Q1NBbTFJL0F1ck9IRXFkT1ZXL0or?=
 =?utf-8?B?R1hSRDJSZlAxVEdtdngrSHlVQzVDZzgweXJLbSt3YU5yRnBZV0JUbTRkMVQx?=
 =?utf-8?B?NkFuZFp6dTdxMitoN3F4ZVB5eTVhZEZUMlU3VzJWemh0MlFyQk9vM2NIMGxv?=
 =?utf-8?B?cUhVQWMveUVQa3cyS3pEcy8xTHFHbU5qZnlLSkFYN0l3YUlTUWNONG1IWE1F?=
 =?utf-8?B?RnFWZyswOWRVdGpBMkpzVVBPS2lDVjFFUTBaUzlpL0c4TndGSzYwaklLTWI3?=
 =?utf-8?B?ayswbVFJblA1UE9scUVhQThlYW43WVhqZG0xVkFzM3g0S2FEY0JubXMzSU9a?=
 =?utf-8?B?VGhKSlZuMWczaEIwa2xnQUVyb3lrNU5MdzIrT3NoU0F6bStOSllMYXVTSEd3?=
 =?utf-8?B?alF5T2QrZDlERnZRVGJ0bTlzN2hud042cGV2blNsYnRxVEo4NFlBM0JyYzUr?=
 =?utf-8?B?OGNYcGNVT3V4TGE1MG1EMEc5Q0JyTkRuOEJSc0tGSmZDM1ZJbjF5c0p3QVUw?=
 =?utf-8?B?TXFkTUVKNS9TRnpqQXNUMzZRM2FiKy9ON3h4dmlPc0NOcldoaDVRZ1crUGlz?=
 =?utf-8?B?VlQrOXB2anFuVU50RENqdUxCWlBxM2ZDNmVtT0RiejdzUTA3cnllbVlXYlBC?=
 =?utf-8?B?Nmh3T1NNcUNlaTlFZFZVZHg0bHRhSXM3YTBEUUJCdm00NjdWb0lWYUpyTEtr?=
 =?utf-8?B?WkRGRG15RGpYa1FTNjNmYnRhMGZkL29JalA0Z0pSS2N5bGgyWWd2d2ZLM0FI?=
 =?utf-8?B?ZXVRYTRWVkZwMmovT0VtVGpyLzE2ci8zWFFrRFoyd3RXSUxtOS9tK2Voc0Ew?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108fd9ae-7038-41a3-e6c5-08de30f175ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 15:51:15.4812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsjqvCcF/FORcNoObhP2FfoQruHPt4iqquAXUIGsN2Ij1Rli1NRnV/L+xNHwy/J7T/utP3sHoD+ztgcaIGlh78scaGn3pEsVzsbJXDw/ylE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9750

SGkgVXdlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFV3ZSBLbGVp
bmUtS8O2bmlnIDx1a2xlaW5la0BrZXJuZWwub3JnPg0KPiBTZW50OiAwMSBEZWNlbWJlciAyMDI1
IDE1OjIxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC84XSBBZGQgUlovRzNFIEdQVCBzdXBw
b3J0DQo+IA0KPiBIZWxsbyBCaWp1LA0KPiANCj4gT24gVHVlLCBTZXAgMjMsIDIwMjUgYXQgMDM6
NDU6MDRQTSArMDEwMCwgQmlqdSB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBBZGQgUlovRzNFIEdQVCBzdXBwb3J0LiBJdCBo
YXMgbXVsdGlwbGUgY2xvY2tzIGFuZCByZXNldHMgY29tcGFyZWQgdG8NCj4gPiBSWi9HMkwuIEFs
c28gcHJlc2NhbGUgZmllbGQgd2lkdGggYW5kIGZhY3RvciBmb3IgY2FsY3VsYXRpbmcgcHJlc2Nh
bGUNCj4gPiBhcmUgZGlmZmVyZW50Lg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgZGVwZW5k
IHVwb25bMV0NCj4gPg0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI1MDkxNTE2MzYzNy4zNTcyLTEtYmlqdS5kYXMuanpAYnAucmVuZXMNCj4gPiBhcy5jb20vDQo+
ID4NCj4gPiB2Mi0+djM6DQo+ID4gICogQWRkZWQgUmIgdGFnIGZyb20gUm9iIGZvciBiaW5kaW5n
cyBwYXRjaA0KPiA+ICAqIERyb3BwZWQgd2F2ZSBmb3JtIGNhbGxiYWNrIGNvbnZlcnNpb24gZnJv
bSB0aGlzIHBhdGNoIHNlcmllcyBhcw0KPiA+ICAgIGl0IGlzIGNvdmVyZWQgaW4gYW5vdGhlciBz
ZXJpZXNbMV0NCj4gPiAgKiBBZGRlZCBzdXNwZW5kL3Jlc3VtZSBzdXBwb3J0Lg0KPiA+IHYxLT52
MjoNCj4gPiAgKiBDcmVhdGVkIHNlcGFyYXRlIGRvY3VtZW50IGZvciBSWi9HM0UgR1BULg0KPiA+
ICAqIFVwZGF0ZWQgY29tbWl0IGhlYWRlciBhbmQgZGVzY3JpcHRpb24gZm9yIGJpbmRpbmcgcGF0
Y2guDQo+ID4gICogQWRkZWQgd2F2ZWZvcm0gY2FsbGJhY2sgY29udmVyc2lvbiB0byB0aGlzIHNl
cmllcy4NCj4gPiAgKiBDb2xsZWN0ZWQgdGFnLg0KPiA+ICAqIEFkZGVkIGxpbmsgdG8gaGFyZHdh
cmUgbWFudWFsDQo+ID4gICogVXBkYXRlZCBsaW1pdGF0aW9uIHNlY3Rpb24gaW4gZHJpdmVyIHBh
dGNoLg0KPiA+DQo+ID4gQmlqdSBEYXMgKDgpOg0KPiA+ICAgZHQtYmluZGluZ3M6IHB3bTogRG9j
dW1lbnQgUlovRzNFIEdQVCBzdXBwb3J0DQo+ID4gICBwd206IHJ6ZzJsLWdwdDogQWRkIGluZm8g
dmFyaWFibGUgdG8gc3RydWN0IHJ6ZzJsX2dwdF9jaGlwDQo+ID4gICBwd206IHJ6ZzJsLWdwdDog
QWRkIHByZXNjYWxlX3Bvd19vZl90d29fbXVsdF9mYWN0b3IgdmFyaWFibGUgdG8gc3RydWN0DQo+
ID4gICAgIHJ6ZzJsX2dwdF9pbmZvDQo+ID4gICBwd206IHJ6ZzJsLWdwdDogQWRkIGNhbGN1bGF0
ZV9wcmVzY2FsZSgpIGNhbGxiYWNrIHRvIHN0cnVjdA0KPiA+ICAgICByemcybF9ncHRfaW5mbw0K
PiA+ICAgcHdtOiByemcybC1ncHQ6IEFkZCBSWi9HM0Ugc3VwcG9ydA0KPiA+ICAgcHdtOiByemcy
bC1ncHQ6IEFkZCBzdXNwZW5kL3Jlc3VtZSBzdXBwb3J0DQo+ID4gICBhcm02NDogZHRzOiByZW5l
c2FzOiByOWEwOWcwNDc6IEFkZCBHUFQgbm9kZXMNCj4gPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6
IHI5YTA5ZzA0N2U1Ny1zbWFyYzogRW5hYmxlIEdQVCBvbiBjYXJyaWVyIGJvYXJkDQo+ID4NCj4g
PiAgLi4uL2JpbmRpbmdzL3B3bS9yZW5lc2FzLHJ6ZzNlLWdwdC55YW1sICAgICAgIHwgMzIzICsr
KysrKysrKysrKysrKysrKw0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDln
MDQ3LmR0c2kgICAgfCAxODQgKysrKysrKysrKw0KPiA+ICAuLi4vYm9vdC9kdHMvcmVuZXNhcy9y
OWEwOWcwNDdlNTctc21hcmMuZHRzICAgfCAgMTMgKw0KPiA+ICBkcml2ZXJzL3B3bS9wd20tcnpn
MmwtZ3B0LmMgICAgICAgICAgICAgICAgICAgfCAyMDkgKysrKysrKysrKy0tDQo+ID4gIDQgZmls
ZXMgY2hhbmdlZCwgNzA0IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1v
ZGUNCj4gPiAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9yZW5l
c2FzLHJ6ZzNlLWdwdC55YW1sDQo+ID4NCj4gPg0KPiA+IGJhc2UtY29tbWl0OiBiZjI2MDJhM2Ni
MjM4MWZiMWEwNGJmMWMzOWEyOTA1MThkMjUzOGQxDQo+IA0KPiBJIGRvbid0IGtub3cgd2hhdCB5
b3UgZGlkIGhlcmUsIGJ1dCBhcHBseWluZyB5b3VyIHNlcmllcyBkb2Vzbid0IHdvcms6DQo+IA0K
PiAJdXdlQG1vbm9jZXJvczp+L2dzcmMvbGludXgkIGI0IGFtIC0zIDIwMjUwOTIzMTQ0NTI0LjE5
MTg5Mi0xLWJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tDQo+IAlBbmFseXppbmcgMTkgbWVzc2Fn
ZXMgaW4gdGhlIHRocmVhZA0KPiAJQW5hbHl6aW5nIDI3IGNvZGUtcmV2aWV3IG1lc3NhZ2VzDQo+
IAlDaGVja2luZyBhdHRlc3RhdGlvbiBvbiBhbGwgbWVzc2FnZXMsIG1heSB0YWtlIGEgbW9tZW50
Li4uDQo+IAktLS0NCj4gCSAg4pyXIFtQQVRDSCB2MyAxLzhdIGR0LWJpbmRpbmdzOiBwd206IERv
Y3VtZW50IFJaL0czRSBHUFQgc3VwcG9ydA0KPiAJICDinJcgW1BBVENIIHYzIDIvOF0gcHdtOiBy
emcybC1ncHQ6IEFkZCBpbmZvIHZhcmlhYmxlIHRvIHN0cnVjdCByemcybF9ncHRfY2hpcA0KPiAJ
ICDinJcgW1BBVENIIHYzIDMvOF0gcHdtOiByemcybC1ncHQ6IEFkZCBwcmVzY2FsZV9wb3dfb2Zf
dHdvX211bHRfZmFjdG9yIHZhcmlhYmxlIHRvIHN0cnVjdA0KPiByemcybF9ncHRfaW5mbw0KPiAJ
ICDinJcgW1BBVENIIHYzIDQvOF0gcHdtOiByemcybC1ncHQ6IEFkZCBjYWxjdWxhdGVfcHJlc2Nh
bGUoKSBjYWxsYmFjayB0byBzdHJ1Y3QgcnpnMmxfZ3B0X2luZm8NCj4gCSAg4pyXIFtQQVRDSCB2
MyA1LzhdIHB3bTogcnpnMmwtZ3B0OiBBZGQgUlovRzNFIHN1cHBvcnQNCj4gCSAg4pyXIFtQQVRD
SCB2MyA2LzhdIHB3bTogcnpnMmwtZ3B0OiBBZGQgc3VzcGVuZC9yZXN1bWUgc3VwcG9ydA0KPiAJ
ICDinJcgW1BBVENIIHYzIDcvOF0gYXJtNjQ6IGR0czogcmVuZXNhczogcjlhMDlnMDQ3OiBBZGQg
R1BUIG5vZGVzDQo+IAkgICAgKyBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVy
dCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gCSAg4pyXIFtQQVRDSCB2MyA4LzhdIGFybTY0OiBkdHM6
IHJlbmVzYXM6IHI5YTA5ZzA0N2U1Ny1zbWFyYzogRW5hYmxlIEdQVCBvbiBjYXJyaWVyIGJvYXJk
DQo+IAkgIC0tLQ0KPiAJICDinJcgQkFEU0lHOiBES0lNL2dtYWlsLmNvbQ0KPiAJLS0tDQo+IAlU
b3RhbCBwYXRjaGVzOiA4DQo+IAlQcmVwYXJpbmcgZmFrZS1hbSBmb3IgdjM6IEFkZCBSWi9HM0Ug
R1BUIHN1cHBvcnQNCj4gCUVSUk9SOiBDb3VsZCBub3QgZmFrZS1hbSB2ZXJzaW9uIHYzDQo+IAkt
LS0NCj4gCUNvdmVyOiAuL3YzXzIwMjUwOTIzX2JpanVfZGFzX2F1X2FkZF9yel9nM2VfZ3B0X3N1
cHBvcnQuY292ZXINCj4gCSBMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNTA5MjMx
NDQ1MjQuMTkxODkyLTEtYmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20NCj4gCSBCYXNlOiB1c2lu
ZyBzcGVjaWZpZWQgYmFzZS1jb21taXQgYmYyNjAyYTNjYjIzODFmYjFhMDRiZjFjMzlhMjkwNTE4
ZDI1MzhkMQ0KPiAJICAgICAgIGdpdCBjaGVja291dCAtYiB2M18yMDI1MDkyM19iaWp1X2Rhc19h
dV9nbWFpbF9jb20NCj4gYmYyNjAyYTNjYjIzODFmYjFhMDRiZjFjMzlhMjkwNTE4ZDI1MzhkMQ0K
PiAJICAgICAgIGdpdCBhbSAtMyAuL3YzXzIwMjUwOTIzX2JpanVfZGFzX2F1X2FkZF9yel9nM2Vf
Z3B0X3N1cHBvcnQubWJ4DQo+IA0KPiAJdXdlQG1vbm9jZXJvczp+L2dzcmMvbGludXgkIGdpdCBj
aGVja291dCBiZjI2MDJhM2NiMjM4MWZiMWEwNGJmMWMzOWEyOTA1MThkMjUzOGQxDQo+IAlQcmV2
aW91cyBIRUFEIHBvc2l0aW9uIHdhcyAuLi4NCj4gCUhFQUQgaXMgbm93IGF0IGJmMjYwMmEzY2Iy
MyBBZGQgbGludXgtbmV4dCBzcGVjaWZpYyBmaWxlcyBmb3IgMjAyNTA5MjINCj4gDQo+IAl1d2VA
bW9ub2Nlcm9zOn4vZ3NyYy9saW51eCQgZ2l0IGFtIC0zIC4vdjNfMjAyNTA5MjNfYmlqdV9kYXNf
YXVfYWRkX3J6X2czZV9ncHRfc3VwcG9ydC5tYngNCj4gCUFwcGx5aW5nOiBkdC1iaW5kaW5nczog
cHdtOiBEb2N1bWVudCBSWi9HM0UgR1BUIHN1cHBvcnQNCj4gCUFwcGx5aW5nOiBwd206IHJ6ZzJs
LWdwdDogQWRkIGluZm8gdmFyaWFibGUgdG8gc3RydWN0IHJ6ZzJsX2dwdF9jaGlwDQo+IAllcnJv
cjogc2hhMSBpbmZvcm1hdGlvbiBpcyBsYWNraW5nIG9yIHVzZWxlc3MgKGRyaXZlcnMvcHdtL3B3
bS1yemcybC1ncHQuYykuDQo+IAllcnJvcjogY291bGQgbm90IGJ1aWxkIGZha2UgYW5jZXN0b3IN
Cj4gCVBhdGNoIGZhaWxlZCBhdCAwMDAyIHB3bTogcnpnMmwtZ3B0OiBBZGQgaW5mbyB2YXJpYWJs
ZSB0byBzdHJ1Y3QgcnpnMmxfZ3B0X2NoaXANCj4gCWhpbnQ6IFVzZSAnZ2l0IGFtIC0tc2hvdy1j
dXJyZW50LXBhdGNoPWRpZmYnIHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoDQo+IAloaW50OiBXaGVu
IHlvdSBoYXZlIHJlc29sdmVkIHRoaXMgcHJvYmxlbSwgcnVuICJnaXQgYW0gLS1jb250aW51ZSIu
DQo+IAloaW50OiBJZiB5b3UgcHJlZmVyIHRvIHNraXAgdGhpcyBwYXRjaCwgcnVuICJnaXQgYW0g
LS1za2lwIiBpbnN0ZWFkLg0KPiAJaGludDogVG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgYnJhbmNo
IGFuZCBzdG9wIHBhdGNoaW5nLCBydW4gImdpdCBhbSAtLWFib3J0Ii4NCj4gCWhpbnQ6IERpc2Fi
bGUgdGhpcyBtZXNzYWdlIHdpdGggImdpdCBjb25maWcgYWR2aWNlLm1lcmdlQ29uZmxpY3QgZmFs
c2UiDQo+IA0KPiBJIGRvbid0IGZlZWwgbGlrZSBkZWJ1Z2dpbmcgdGhhdCwgd2hpY2ggdW5mb3J0
dW5hdGVseSBtZWFucyBJIGNhbm5vdCBwcm92aWRlIHlvdSBhIGRpZmYgb24gdG9wIG9mIHlvdXIN
Cj4gdHJlZSB0byBleHBsYWluIG15IGRvdWJ0cyBhYm91dCB0aGUgcmVzdW1lIGNhbGxiYWNrLiA6
LSgNCg0KDQpUaGUgZGVwZW5kZW5jaWVzIG9mIHRoaXMgcGF0Y2ggc2VyaWVzIGFyZSBjaGFuZ2Vk
IG5vdyBkdWUgdG8gWzFdDQoNClNoYWxsIEkgc2VuZCBWNCBvbiB0b3Agb2YgDQoNClsyXQ0KDQpv
ciAgDQoNCk1lcmdlIFsyXSB3aXRoIHRoaXMgc2VyaWVzIGFuZCBzZW5kIFY0Pz8NCg0KDQpbMV0g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51
eC1uZXh0LmdpdC9jb21taXQvP2g9bmV4dC0yMDI1MTIwMSZpZD1mYWUwMGVhOWYwMDM2Nzc3MTAw
M2FjZTc4ZjI5NTQ5ZGVhZDU4ZmM3DQoNClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyNTExMjgxMDM0MzEuMTZNZXJnZTE1OTEtMS1iaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbS8N
Cg0KQ2hlZXJzLA0KQmlqdQ0KDQoNCg0KDQo=

