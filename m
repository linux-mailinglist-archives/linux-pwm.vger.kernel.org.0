Return-Path: <linux-pwm+bounces-3192-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BC8974318
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 21:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBC91C25D94
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3C31AAE27;
	Tue, 10 Sep 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gjLAY4YH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013052.outbound.protection.outlook.com [52.101.67.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E691A7AD6;
	Tue, 10 Sep 2024 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995272; cv=fail; b=I9EeAFzu0eAWhwkVrWv8W9Qw8wzFOFLGl/voGkELbmtthFvo7idk802eIbF/a1gFRVgCi5lshll5uXQw84mRfr4OCleL1czWe4qHxhoRBO2qRhp38/HshTw5ScBLLhN8pQZQ8A9103HY5Wmfh6Npl+VDN+dbJHCcrDkwIofQWEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995272; c=relaxed/simple;
	bh=7cPnhCSJUSFQl0yVoLJxwbOrnCIHH/QeAWGfdDS7p3I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k0tXtE+M2dR20Zqw1KIpjjbSfcotKUvmtIUSC6blsqZ4XFqT2EM9Y5+yhU0i7BQsvVvJic7Z2jNK/DeNM51zJHMViaw/QkS2OcnLDJ5JEdaAzxJH/xt1vHBgh+ylblm7HgI+S4GvZwKwJsJ/aAYo/NXQyj9QXpRP2wAG6BQrZHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gjLAY4YH; arc=fail smtp.client-ip=52.101.67.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Op+sTRss2a/ybrnVnsykXl+jkyBHi1BV2IU4skeSKYRDIR1HfS3yid3h0O8MdiRlDnVozxbtTt4f1CnjmCKm+oyWc1BzcNVDqDHil1BOIpUCkM74GpPK3XJ/Tga4BgxWj6s/Si5vWQ5zFmxyV1ylmOmjNhDa4CwlKqsel1jxMq3J4aOCpS/6j09GrpekNFGEgElbB26/lfDo9rIi9kBva+edapDX1QowSXd5gM+NFaUZZpks3Hf9tlD3It6uSzFpz2epYBMRQekf7wmvCSbbASYgnJuen9zRnmEdZwy20chQVF5VQuwdt0XOqsw1NmZ4Q6b8j/1y00klaPO89DCE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S5qPC9dLd+uFJW3y7aEhwRdoqpfhTFn0U6wBratWY8=;
 b=EEUCoRAtnwe9wVVnbGbNLF42pa70bLlrkZRYKHRQ/pKc8e3q6iWHK7ZqAz9yrGvuCL3fdBbb3xkD+KtjNPSsdkBNYKN+kswUYZqYJqrBM/mcwVLCjVcGwkMLu+z4WjVPaS924w6ooWdqh9i4rBdkkfhiZLoYE3pyJ9MhjL04lm2tiaSS1HxGrz7ryEceqDv7dn1V20lFH539YmbyV4EyySNYehOnEOiaNOEVcop+7Il0OnM9+ZY1GEaGtSMRzMwO4B7Rm+KuBMcD7gxtEljxU9X4qI9HD9b0A7YzZIs8i4zcdiJex0AHdpz1iqLfdZl8GU9iq96aIzSXm6dyQsNerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S5qPC9dLd+uFJW3y7aEhwRdoqpfhTFn0U6wBratWY8=;
 b=gjLAY4YHP7y+JL7bJrsVz4uvKu/W8KxGEXkwQTYb3F1huOA3iIR4UvdESnf0wcff+jyUpTWnNsrK2T7wJNI5IyeUGLByRoaak3k1HQW2YlRjOErPrl/cD4gS4zZZnZfwwDs2OkAH55ObdLI0i6pEpUZNaRuVHn+2zmmEdePzwKBmXCpb8SMkEU6uH1NymrA0mKisXu62JGyjpvbuLsWTVbT7iTaLttHDDfhDHJPUxf8cPkN7g56Vtg/k20RCYwtCE5gnN6nneEggsgeDfYEfxnWVwBgTQXigfJL8EUnnw5vXeo3ITAFjO63CzJZu8KlCFqXm78oVO6GuchCkF8+iUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10115.eurprd04.prod.outlook.com (2603:10a6:800:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 19:07:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 19:07:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 10 Sep 2024 15:07:18 -0400
Subject: [PATCH v3 1/3] dt-bindings: pwm: imx: Add optional clock '32k'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-pwm-v3-1-fbb047896618@nxp.com>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
In-Reply-To: <20240910-pwm-v3-0-fbb047896618@nxp.com>
To: Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, pratikmanvar09@gmail.com, 
 francesco@dolcini.it, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725995258; l=1015;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7cPnhCSJUSFQl0yVoLJxwbOrnCIHH/QeAWGfdDS7p3I=;
 b=Bam3qE7LdW7I8HK40G++J9Q0EB+MBDWjitKUiXZu3VvyFX7WYHIGXD5FQeHsAq6Y1vE5HF6SR
 KunCul3BIqIA7SWUVYZMgADG8IdDa7Xoe9WV7R/v2+/MzERRUsmErMS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10115:EE_
X-MS-Office365-Filtering-Correlation-Id: 2358c602-47fb-4aaa-97a0-08dcd1cbdbcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1pBQVA4RXk1QlhnblkwMzFaamg3RmNOZlNucnNteE5KcWJxbUFrejhUWG1H?=
 =?utf-8?B?SHBYUTZQVlhNa05aVjUzQzhnV210MERQZTNrc3YxQkF2MTFUd09mOCtaMWdY?=
 =?utf-8?B?RW1uQkJiWGI3Qldycmd2QjhTK1lUeHlCNi9Qd3JTMTljcG1ud1N5ckdOMVZX?=
 =?utf-8?B?K3lyOHNyMWFTOXFCZzlNNlJabWFsa2NXTE1CUk9RbjZlM3hjME9FUFZpWnlJ?=
 =?utf-8?B?Z0FWR2ZROG1LdHpwSDMzM005MFpHYk9uZWlndUVhdGNTTXZ2V1VhRDRoYk9W?=
 =?utf-8?B?aUg1ZmFDUkl1MzBhZXJQRXN0UUxYdjBZOEVnTDc5NmhLZjEwekRLYzJhZXll?=
 =?utf-8?B?U3N5NDBVZzVQdHFuNWlsWEFvdlp1VldnN2ZOWVJ3VUF2MkNPU1FkdXQzRk1i?=
 =?utf-8?B?Q0xmcmN0Vko1emQxRnlNYXg3VUZpWDNqamZVdlE5TnhOc3lQbDB6aGhkSGxX?=
 =?utf-8?B?QzJYQXNsMkRZNG9xVXpHdUJZT3N1M1dlSkdWdXBQWnFkY2k0YUhWZ3J3bXUx?=
 =?utf-8?B?SllITjYvaTNZY3FicDI2SUZCWXl6QVpaNys2ekQ3OFFHa1Nad2p1SFNTSXpa?=
 =?utf-8?B?UVdyYkhwTTRsd1BYNzRJQngvTHNrT1ZvR2dyZmVialdRTUJvWUQ5UVFCeEdP?=
 =?utf-8?B?QjlLUWtXVEs2dmFnYlJpR2Z0Vk1VZEIyWTlsVWs1M1FWaW4xRmlEQkF5WEpZ?=
 =?utf-8?B?dDNNSDljQ3dONnZtMWVpOGdYM2xuUnhvZFdTeFBkUEdtanJHSm9wK0N0akEy?=
 =?utf-8?B?SVUvSzN1eS9qTXpkSVkzdm0yd2c4bTJ4QTBWUDFpWTRWVmRGZEc3V1h3bTRP?=
 =?utf-8?B?TXBGNDNrMklGa0loMzdaNzNNTVFXYnhTL2dWVnlZcmJlTzJkeWk3OWd2ck03?=
 =?utf-8?B?UkZaOUF6SkxCR1NCbWNYWHE2MDNRVmUyV2hsNllMdmVHTDV0VjdUMTZHcGg1?=
 =?utf-8?B?NHdiZkgrL0tHbHcrMHBkU1VXdW5NdjBKNFN3UmhiM3dzOWo5eGxBRHU4dW1s?=
 =?utf-8?B?djIva2xIWkhvZllOeHZZekNEVmRXK1JsaVp5eGsxbU5kdGx1K2QwWFlkckxh?=
 =?utf-8?B?QmM4TkpzaDJ0NnRVRzNoeHlFdHhoMjUwV0E2bGxZNzlZUEQrRUlsNEswbG1M?=
 =?utf-8?B?OFRvYnhldU91SEdDdlB1YzkwTnpkS0RBQVhKbzlPeHNnM2lJRU8wWXRYNk1Q?=
 =?utf-8?B?amhIM2FHanRaRTJPNmxBMzNzYzNlT2tUUVdjTHpaM0l3dzdsaDNQcWpYYmlP?=
 =?utf-8?B?M1NwalY5OVNrZXlTRWcvMitWaFJjdkl1b1dWeFBYTWJxWDNKVUJEbXV6blNG?=
 =?utf-8?B?Nm9sYzYvWFZBKzVHS3Vaenl1dXU2bVBoWDFIQ3RXR3E1ejNkbnMwM1M4VDFi?=
 =?utf-8?B?RnlhQUNvcE81dHJ6MWpYOG54MVZ1VGdoYTV0cWRZVmdjZVFHeHN5em9ObndG?=
 =?utf-8?B?MW53Wmo2MDR1VTdCZ2RrNDVKdVlBSlNIRUF5cyttRDFGOEJDZU9GZTZkWktS?=
 =?utf-8?B?dWdLSEM1Z2dacG1ja2pUTVhTek1mdTg0a0RuWGZtOHZ2TlY1aTdVOW1idDgv?=
 =?utf-8?B?cXhwWHRtandRUnJGaDVML2ppdVpDZ0lSSGdNSytxTGk3ajgxZGxGSXp6cUh6?=
 =?utf-8?B?ZUVRZm93RXg5N3Z5aEhGUG9Nb2VNeitLVXNJZ0lpV1hrSEJTL3RGRDdMY21k?=
 =?utf-8?B?QkRtdERGTm9yMHpPdDBFZUlkV0MvZjIxRnZkMW9BTmhOWkR6MTNwSTgyT0F0?=
 =?utf-8?B?UUY0QzZPcEZwenFIR0ZqSkl4M3E4OGh5QjFSeEpwelczUUM4K2UvdEdwV2lR?=
 =?utf-8?B?ZmFIL25VQzJSQlBLN3JQTGxlRmNTbWlROTJKMHllRkFNMHFxOUJjQ3NMMTdu?=
 =?utf-8?B?TlVKTkhzMDVWN2VUaUp1VS91ZE1MRVZqWTd0cm1NYUd6cmRjL0U3S3VzK1dG?=
 =?utf-8?Q?EDKRBT2Fae8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmRDWW8rc0V4dnV3bG5kN0wwTzZzMmxZdml4ODhyWmFTNGY2WTgyZjZOMkpi?=
 =?utf-8?B?Z05CTm9NaUFBbDFyb01FMThsV3lNbUtaYS9IaXFwOGJSYytnNHVpVGNaLzZE?=
 =?utf-8?B?L2RFVFJlU1FZY3pXQ1hidWp5RDhjdzhiYWVyOHd3WWN6NmhBaTFnWDBTeGdz?=
 =?utf-8?B?WWdMNURlUkNFVVJpNU40WnV4WlhtU3RHcGVHR0R4UUxETjhYaVF3eUFsMVlk?=
 =?utf-8?B?UWdZemdCK1dJcWQ3Nm11eDg3UG1LaExLNU9PUzNmRDNhdEUvenJkV2sycjdV?=
 =?utf-8?B?Q2J2b3A3YU96cG0zbHRHdkJVZU1TbkhZQi9IY2pWc1RKYVhFUkRaQ2c0a0tW?=
 =?utf-8?B?TEVUdEE0RXQxNG9IWjFxVnp1UURPMkxJdEFGMGtHMGhhL1dUWmxqY09kSkd1?=
 =?utf-8?B?RVVQY0ttZWwwUDc5NWtqSG5GaU55ZXg4NVVGN3N2ckcvZTRtem9objAyNnpp?=
 =?utf-8?B?anU5QmZTVlIzUjc3TWZ1YmRlT25iM29Da1BsUlhQeWc4bEhzN29uWk01dU8r?=
 =?utf-8?B?YWgrVXdIdkhiTDhDL25pQnBZUVhIUmRjV1B6ZGVSMVBwSG9JR0ZDNGJqa3Q3?=
 =?utf-8?B?ZENJeUZiVGttclYwcEdic1Y4TUZHeGVHUldmNlgvTE02ZjVDT0RPUGhTUW1Z?=
 =?utf-8?B?VzFVb0laTE83T2RGUStoNk9WUVkrNEc3VnpNRk5kSVlxcElHLzd5b3JwV2F6?=
 =?utf-8?B?akE2aENxMTY4Nk1GMFQrQjdZQmZ5SVBwVVRDYTd3RXBnZzN1TjNZazN5SklE?=
 =?utf-8?B?OCthZXJ1NlpXS2FJNGJMTlNYdjY4QTBFckdTUEhialBlMEUwNmNHSDg5T3l6?=
 =?utf-8?B?bDJ2dDVoNjJKYnlxQUU2YmF6UUxjUHZnOElyR2tpZUVLdVdzbnJnL3pYYk53?=
 =?utf-8?B?OHpiZ1ZHUDJ6Y2taVTB4WWxuWGl3VWRyMFhxMlNsYmQ5NHhuM1VpRTJteGsv?=
 =?utf-8?B?U1N0VmJTRWpKSXJ0cytYaTZJUEpOTTh6REEvYjBjZzlLcHF1R25vNW1mUGJz?=
 =?utf-8?B?QWFxWXNPdDdxUEdTRlN5ckk0Ni9LUmNMTFk5Yzk5ZlgzTngxRmhTT29LN2VX?=
 =?utf-8?B?WEppVy8zUnM1L2lpOUpYSC9RVU5HNlp3NTVkS0pwc01UajNFK2VVOEJBd1RG?=
 =?utf-8?B?YVpSTjNiZHdxNi9aRjZIbG5qUTlJN2RxV1k4S2RSNVdZeUlBdUFnRktVQnk5?=
 =?utf-8?B?NUtnenBsdmdYRWNmSUJkS3FUQnBIRDZUOE5iOVBhMTJUa05lNVU5Q282aXln?=
 =?utf-8?B?blVVVGZUMjd4M2sxd1MxZDRrQ2J0NTNmSXhpNmlPb0taTmR3Q0hDSlFEQ3JR?=
 =?utf-8?B?TVVUTVFZVngzMi9XMUNYU00vN2J6dGFhSmVkQzBqZVJIbWNtbjkrMVdRbitr?=
 =?utf-8?B?RFFwV1l6VDZYQWRxYTMybzRqZjNkWkU5SVlxcjFtRkRSdXJRUEVEV052Yk9G?=
 =?utf-8?B?RHlCUEFpaldUbURXZGFWdnJYY2xoY2d6a1lvVGN2ejhGU2NsT3Y0YTNzMTJ3?=
 =?utf-8?B?ZExOd09tL0JKUjZET0hCYk16cFVYZkZxa3Y4ZHovYlk2Q1NWT0FIMlBKZGl0?=
 =?utf-8?B?UW90bkhvN0tuZXU1Tkt1NkxTMzFjaWZlUkNOOUxzRjFQbFBYVzNhNFRNUlUw?=
 =?utf-8?B?aVdKQzZoSEMwUzNldGk1aGxqV3BUSUxQZlUvMVlyMW1XMzV0Y2xvREQvRk5U?=
 =?utf-8?B?SGJnNFZLQm90VzlIVVVxUTZvWmQ5VGR4Yjl1dWFKQm5oV2puajlXeFdCaVky?=
 =?utf-8?B?ZUNsc0paRS90SzhxU045Y3B4WDd2NFMzTFRodG04eFpTVmptQjc1dWtwaXp4?=
 =?utf-8?B?ZTRsQ2VYK1JqeWk2b2RwRkY0SGFsV3dQMlVMR0xEQVBaUlpuRWthZnNiamVa?=
 =?utf-8?B?UitJLzRwQjAvK1dGVlR5VlRWRmdPaHhmZVBveVhBV3RUY1MrRTB6NUNoVm9z?=
 =?utf-8?B?azVGaUZMUlJ4ZGpYUUQ5MFdGOFhrb21vNThSU2dhYXNub3ZzS2QrRnJ5TkMz?=
 =?utf-8?B?SE5xZ1BoWUJwMzh5U3lVZ1NPSUU0akhTVi9jdmI2aG5HNVlqSGkrdHNpeS9y?=
 =?utf-8?B?cGdEc3JiVmh1dG1VMmFmSlZKMHdVNVlmYmE0S3lqTityK0I5dUVBWC9lU0tQ?=
 =?utf-8?Q?hamE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2358c602-47fb-4aaa-97a0-08dcd1cbdbcc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 19:07:47.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TrNZ2CmquKfk+8L0bSiUTMfyg8ocuWj/qWVtKcT04dSwIjeBJmSKZFiWVnPVWWa7LVabEjQBgrvwjrViSbwEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10115

The pwm in imx8qxp mipi subsystem require one extra '32k' clock. So
increase maxItems for clock and clock-names.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- remove compatible string fsl,imx8qxp-mipi-pwm
---
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index 04148198e34d0..bc6991bd466e1 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -51,11 +51,15 @@ properties:
     items:
       - description: SoC PWM ipg clock
       - description: SoC PWM per clock
+      - description: 32k clock
+    minItems: 2
 
   clock-names:
     items:
       - const: ipg
       - const: per
+      - const: 32k
+    minItems: 2
 
   interrupts:
     maxItems: 1

-- 
2.34.1


