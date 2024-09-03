Return-Path: <linux-pwm+bounces-3075-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC569969C9B
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 13:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9525B2860A1
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 11:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68211C7685;
	Tue,  3 Sep 2024 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="PYG2aQc0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2136.outbound.protection.outlook.com [40.107.104.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A81C768C;
	Tue,  3 Sep 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364722; cv=fail; b=kRfcDfHg9aZv6kai4KgQRk64GKw4QYvYjIcZzPp3rSGUZ12w5v6xc2Y68/4YuXwXD/5nR/bKFmfsAgE7amOwUyt0oHhs6RqZmQ8y33Lj4+wdGQe4/P9b0F1+DfilHBKC4dDU6oSXP6TcRg4GVv9h/a7U0LGcYnkc3bEw/B8665s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364722; c=relaxed/simple;
	bh=LF+gfTAEX+0bRNPHnNk8phaLv7Vo1dT7EbpiHNSqIkI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HAaNMSvh/xoYf1bEVZtp/1WSpQtrneHWkpj2OTWWJGEAIJhmmvwlt6AuwbXTVS/6xOIx1O0BTluuLoQIayC59o4nLlho0nJFN7mXKkGgRPaUovin6D57BEtHxTT4PDZsSzuFZ7NyO/Qi564FwQtBdQQUfyyFdZ6YOnvQTNpURF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=PYG2aQc0; arc=fail smtp.client-ip=40.107.104.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVkfqggE40uQ9hAcRA/+R7DJNXD+MYPcSuvBAgMmDBX5WPe9w0H4s096Dn0BopOP0sdDIPvzRW+ynawR2/OMUvgbmEkgEzHaSGCDTlf51gE5VVi8vH14vsD5Oqarl2EKH7NukHt/D860wK3YRz5O6xegf3IefZcQYxYvJy1wDM8vVap2dBIWd1ZGDxlAkorf2mwQO9XXuohbaoEuogzgajGskHntjm2g+V5lWONPCZxSBsfFSejlFEBBv3uGYvpWJLsenQRtu63macJ0Y6CinG0JpGtij/tGXf5AACp+0K2eOzGP3DIzLzBASKQ4LWnNMnBb2lZYTrjRsXWxYZstYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTNCRg72wN6aKoqlnH3zPklMaLUFvlQBbZvvpKmn6s0=;
 b=S1KXUkEfHYk+v5hubzWlcmia35kdbUObozw/8xHDQwZV6SZMgEM8bcPAR/TAWaTqCR8+Ae9R2tFCn7ylsLaJwDJwJ64x1UbQaC58HuCpoVcL496w4JBzEcophWw2HBxKtfSW/K7tJksnvrNlkvyutykCsPtreJBLjSCh0L6enYQGynbCA8NfuVDHKCOqInk7OeNJLvJqW28rdM9mYNK2dQL176im6sJ/v5mV+5MJkBj9+DZ+rhCb85Q09Edo4qbTCCjC5l4VeilFfL+Pg5zj2lmaa5LQvCNfHuYBSIGGqjZk9OcD9It9XWhUxtAtOM/3PsR59qBEH4ccQg6PfUq7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTNCRg72wN6aKoqlnH3zPklMaLUFvlQBbZvvpKmn6s0=;
 b=PYG2aQc050mfPyHnm2lvVCrKGDq6BKy27eiayxxNcyMNrWGOpy49jsF9140WMY5TDsCgHqkEgNvQqzHPgLSbEz45B2yJ0TGxrGPjeUjy/CB2Od/xneext0Q7aDTKd+vYEx3hGVxdq9TGI0BPRqD7jNNB18crh7tygWDXeQBaUEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18)
 by AS8PR08MB6310.eurprd08.prod.outlook.com (2603:10a6:20b:292::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 11:58:33 +0000
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35]) by AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35%5]) with mapi id 15.20.7939.010; Tue, 3 Sep 2024
 11:58:33 +0000
Message-ID: <d9298199-fe10-4b28-8e28-dc252bd6832c@genexis.eu>
Date: Tue, 3 Sep 2024 13:58:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] pwm: airoha: Add support for EN7581 SoC
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
 ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
References: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
 <20240831-en7581-pinctrl-v3-5-98eebfb4da66@kernel.org>
 <yfqmlca6cnhrghpo5s6tml36tngmekcfbyjakxs7or7wtap3ka@7qlrxjowo4ou>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <yfqmlca6cnhrghpo5s6tml36tngmekcfbyjakxs7or7wtap3ka@7qlrxjowo4ou>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVYP280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::17) To AM9PR08MB6034.eurprd08.prod.outlook.com
 (2603:10a6:20b:2db::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_|AS8PR08MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc8b341-9409-4e58-98ee-08dccc0fbc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VURZbWR0ZkRQdE9STXVtb3hBby9SbnRoeGZ6TTFzQm9ORE1CL0dudGREKzAw?=
 =?utf-8?B?QWdoUXlIbmVrdThoOXBBVUllL0hjaHRMVUpWRXBPMCtsTFVveER4bTlSclFm?=
 =?utf-8?B?b21mRGc4WUdpOEErM2lGQ3FYTGpOL0xVdkFMUFdObjJ0QUlFNUh3ekpLYWNM?=
 =?utf-8?B?ZHZYc3VYc1pqZTlzSlovZUFvWGR5M1BuRUJLWjNXRTBjNytUSTZjMUlxQzNk?=
 =?utf-8?B?K2lsVDkwQVFiaXpQNjlmaUVjcHpTNXo2SGRsSzllRlJYZXhYUGN6NDVKc0hL?=
 =?utf-8?B?R1krMVIzOHhTZUdwMnNoWXNDMlJ3VnNhT0pucWgyb0xjdnhhSnMrcnJ2MWFF?=
 =?utf-8?B?YWFuSTllKzZNdGU3Zk81ZDcvWHdrRnFhLzVEcmlzaUM2UWdNNjdNcS9KSzhX?=
 =?utf-8?B?RGk2ZDV4cm9JQTNKUzhkSHg0bmYrSHNZMUdGM25VZG1xNlByQzJNUFM4ZWlh?=
 =?utf-8?B?ZUw0TW1zUm5NYkgwRHRzcllsbW1oTW5Fc0RBQ241WVJmSmtocTBBbTZmbGMr?=
 =?utf-8?B?bU90eHdSMWp0Z0M3UU50eUs4VlBZVXJjanJJZzhGUmwwVDBkTjhXYld2SkFj?=
 =?utf-8?B?TTRNSmJYSjRjdjNTbzdyYm4vUUFrMVQ1d0NHbU5teGNqeUNBMHI3bDc1TCtz?=
 =?utf-8?B?WkFKbWVBN1B1YXdzOTBrekNLRzFpbWNFM3Bpam9OYUlrcW91MHNWd1FkQVJk?=
 =?utf-8?B?VlcrWDlzN0I4Tzh2dWx0V3E0VDh3bGZGckJXUkhzK0FjUXJFNnZ1QXoxbE1L?=
 =?utf-8?B?S01VSmNuQ3MxYnU3Q2MvRzZXZjdpT014SzRRMitQV3FpaXpoMVd4WksvUGFU?=
 =?utf-8?B?Qm0wMU9ndGJNazdWTXVPZStFNmo5Z0ZkbVZjT0ZyZEJlejgrbzdwRVlCSnRo?=
 =?utf-8?B?TE9tOUNyOHpXcXF4UGs5M2didGVnaGY3ZWpjeHVXRVRkRDcrZ3gyYlE1ckZJ?=
 =?utf-8?B?UTVnMitHVUQ0V0tqMFE2TmtpNHMrNk5LWkwvczdQY21LaFE2bVRBWHVBOWgz?=
 =?utf-8?B?cFYvU3pjRHp1TU5PM2lNajdjazE3MUZsbWZEb29uM2FZMWY4Y1o0NTQ1R1hR?=
 =?utf-8?B?Mk84bjcvWUgwOFk3VjN1S0w5RWNnbnM4UXZ2VFF5V0tkazhjb3QydUl5V2Rl?=
 =?utf-8?B?cFIyY0U1S1JsNDB4NDhkMUVTd2hOWXhzUW10UFdzMmExYldUaHZVQmJYT24z?=
 =?utf-8?B?ZHUrWmxtV0RNQUJrdGZrNG9IenA5NWRIb0NrTFQwL3RFTjl3QzJ6c2FweEtE?=
 =?utf-8?B?MVQ3NDZEVlFnZFkveWxKeGxVYVorem91NmNpeWxaWjN6NklGQm4wMVJsakhQ?=
 =?utf-8?B?VjNHZ1dEa3JIeWtncUJJK1NVL1lweFR0bFUvcklySm5qUUtCRm5Ga0Q1Y0dn?=
 =?utf-8?B?WWlQdE1qL2FXYk9mNm9XYStBdmpWSmZaaDVKblRkSzVOOWxoVU9pNUEzVWQ1?=
 =?utf-8?B?TVVFdHV6ZkswSElPWlltNDU5T256OFljL0NuSkQ2YnlEQnZDUktsZzRGNUVx?=
 =?utf-8?B?aVU2OXRodnlYcnNOYnZCYlkvM21PYTRWNHRjcXhiSTRjRlRUQ3ZVbnp4SkF4?=
 =?utf-8?B?MkEwV1JsVUhLTVRVZWs1Z2xma1IrZkhWR3Nvem9wMTQybjlPcDFnYmhGU0l4?=
 =?utf-8?B?SjZlMHFzTGs4RnpEQXJMbUJRdGNBcW9lbWkydFRpbGZMRm5hOW1QZjExdjIr?=
 =?utf-8?B?SFNkS0dFK0xEOGlZMTd3SlRsaStzbmF5aGxwa1dxTXB5Rkdnckd5dGxVYWNH?=
 =?utf-8?B?Z1VFc20yaVY3MkVTeWd0L1ZieW5YTHNsSnFwb0tpQ3JZSUNmQkR5ZC9xY1Zt?=
 =?utf-8?B?K21tcFIxQnl5NFViZ3BzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6034.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGFTSzlUMCtuaGFjZ3VWcUZIRjdjNE9BWWtiM1dVRkI0MzcrODByT1ZOUTRh?=
 =?utf-8?B?OGdiaWVrMmFOR0MvTFpqQmkwRjc2WVllR0lkYmg2Qm9sSzJ3VFJxbjhWZlJ1?=
 =?utf-8?B?TXlob3hqUVlyUWczOUR4OHpKRGN2bFNvZklhTndEMWhDRy9ibHViRHdJUDhO?=
 =?utf-8?B?Siswb0MwekJqNmlkQ203a3dLSWZuZDllcldUT3gweW9mM29DSmlTUHAwYjQx?=
 =?utf-8?B?eDhkYXgrRzhVZm92QjgzKzRNcWluRnZOSm5lZnFJYnh1Z0thejNqVnFRczlM?=
 =?utf-8?B?VUo5N1V5ZmxPSVFjZklzMS9xUTdHdnl5QWg2YU1wQmZWdy9OTUoxNGpOd3hI?=
 =?utf-8?B?S2pSTGdnc1dFY0U5MXRuYTlBNlNKMFhNZ1FjZmhHVWI4R2crU25TQlpiSUJQ?=
 =?utf-8?B?N1o0K1hpYXBBc1BkVHBGT1Babi9wUUxmbXppbWREaDFwMnp1SDNoTGRwT3hi?=
 =?utf-8?B?RWxJWTFPOFVnWjk4RnVpSG9HRW5tbkpnS3AwanlTdW9ERUdOaVRzTUE5b1Av?=
 =?utf-8?B?c2prNjdvaFhLQjdlRzdkY2dkZi9ER0t5SGtSWUdHWnQrTE53TnhPUXNWNDRp?=
 =?utf-8?B?TzhnWVBPSEtNMVFuMWNEb2ZlMWVQek5LWDJaUG54L3ZTbnlNYTNzR3U5WDVk?=
 =?utf-8?B?dUM2RkozK3BDaDZvSWlvZm5pWnVHVEFXNDl5a2VYTkNBeVJ1aCtTbm5JTmJo?=
 =?utf-8?B?VUE0WlhiUHNUZC9UVjFUbkZ0Z0R5SGxpUEdTOTB3THhVam9HWkhJa1laN3gx?=
 =?utf-8?B?YVhLUWZiQWZya3pvWG9wVm1Lc0xnaFNCaWJ6cWcyWEdkUmJUUWxPYnk0QWcv?=
 =?utf-8?B?bDJYSGVETWFTL2pGdStHQzJ0SU5XTHFBS0xEdGp3aTBMTWd0RUkrMm1iQjRX?=
 =?utf-8?B?c29Vbk1wcmpuWVZmVXQ2OERhR0I5UFZZUDcxaHFTb2lacmozUlFnRGt6QUVr?=
 =?utf-8?B?ZTYwSTBMc3lIb2Znc0Y1WXlCN3dqZHI0TS94akN6Skd5b1BGZ1R5ZS9xRWRy?=
 =?utf-8?B?Smh1bkF1OE55Wm9ZNTB2bHZOZDdKVTFOYlpRMlNEUUpycHJhSkdXdHVVcEE1?=
 =?utf-8?B?YmdpYis4allRQ1hnM1VEM0ozWkNDYTRkeDVJci9EY2cxUWorTmhva0dwTWkv?=
 =?utf-8?B?a2tKWkVObUYxdE9yWHhGV1RpWkh5elVKNi9VSkRzK2I3dk5XRnV6VEszYUVD?=
 =?utf-8?B?aWwzdmdmZHRKR1UyYndvNk1PN1lwVm5lWXgrLzJZcVNESVN2clFXQUcvTVVs?=
 =?utf-8?B?eHJZUzRGaHdJbmpsbHY0MHd0dlhpN01oeXZNU0VZaUhqY2p0U09DaWhLQlBV?=
 =?utf-8?B?b3VPcHpTOEg5RWtNcGhjVzJ0L0dIRWhRMVp5clpIMnRGNFdvMi9lUjJXRlhn?=
 =?utf-8?B?RW02djNHUVNweGpWZXd3MHNSNS9FNHNHVzhpc0d4YXpOcjRtQ2dEOWRpK0pN?=
 =?utf-8?B?cDQ1QXBwQ3JaajhsTFZXYlkxSmxNdVZxblN6Q3FhMS8zbXZNaGdCcExlcDJo?=
 =?utf-8?B?SGt5bUxjdFRpQ0ZYUzlvUjZGTVdDZGU3RHR3em9jenhITE95MjRBUHNiQUJm?=
 =?utf-8?B?cXgrMnd0ektaUVplTzcrcDlZMk1NY2tUMTA2MmRGMTV6d0ExVnRBVUlqRE9S?=
 =?utf-8?B?bkJXQ1kyTzlScTBnWDZSQUpjSEx1SGMyYUFKaHZOUUhJaTB6S1ZJTkVkdDlD?=
 =?utf-8?B?Ui9qTlNRRGo0azdoOWw0UGtqNFFPNmM5dUluVUdMOS9iZ0hVRGVsZ285ZUYw?=
 =?utf-8?B?ejVXN3R3RXp0VVBJeHpnOVlxbjNJVXlTalN0WDlPaFhLajlFQXhqSHBlUzVC?=
 =?utf-8?B?TXBia1ZUdEw0QVFkdjZkQXdEckd2aXhxajhBSjNlWkl5WlNEMzRUU202OUlJ?=
 =?utf-8?B?a3FFenl5T09TSHh4OWx2V0hWNkRFa20wVlR3U2hsaWZqY2k3TUZ1aEtqNll4?=
 =?utf-8?B?Q2UrWjhNbVJaOFptRUZyRjJwTXVlamlaYW04VWM0WXJjQjd1emRmZzlBRVow?=
 =?utf-8?B?ckVaczRTZ2o0K1gvVldob2xObW1TZFdyanpTTlNsR3g0ZWpVY2t1aWthVmFq?=
 =?utf-8?B?TFhaNC9YWmZpWXVvdDgycTdocjhsUnRQS291ZlJKeEc4U014MVdBenAxVS95?=
 =?utf-8?B?VGFlWEh2K0NrM1FGbVBCR2w4SDVKNWJlVFRZTGdPc1AxcWdJK0hndGovREwz?=
 =?utf-8?B?QnBUa3dpV0pGVGVIbWcvbVR5ZlJSSEhIQXZqVk11WEN2N3NrcjZvSzJFV25L?=
 =?utf-8?B?RC9veWVuSlY0MzM5TUZ6M05GTDRnPT0=?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc8b341-9409-4e58-98ee-08dccc0fbc20
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6034.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 11:58:33.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ft4sqi4VJLtvlhDAFcLLyqaEshEM1qbhz04/3e4Hdi9VRhaVWUfsH7YNiQPl24mbNrAMRZpbeC6n3PZfN9+eukx4kWEArOvEEitQu501YPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6310

Hi.

On 2024-09-03 12:46, Uwe Kleine-König wrote:
> Hello,
>
> On Sat, Aug 31, 2024 at 04:27:50PM +0200, Lorenzo Bianconi wrote:
>> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
>>
>> Introduce driver for PWM module available on EN7581 SoC.
>>
>> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>>   drivers/pwm/Kconfig      |  10 ++
>>   drivers/pwm/Makefile     |   1 +
>>   drivers/pwm/pwm-airoha.c | 435 +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 446 insertions(+)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 3e53838990f5..0a78bda0707d 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -47,6 +47,16 @@ config PWM_AB8500
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-ab8500.
>>   
>> +config PWM_AIROHA
>> +	tristate "Airoha PWM support"
>> +	depends on ARCH_AIROHA || COMPILE_TEST
>> +	depends on OF
>> +	help
>> +	  Generic PWM framework driver for Airoha SoC.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-airoha.
>> +
>>   config PWM_APPLE
>>   	tristate "Apple SoC PWM support"
>>   	depends on ARCH_APPLE || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 0be4f3e6dd43..7ee61822d88d 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_PWM)		+= core.o
>>   obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
>> +obj-$(CONFIG_PWM_AIROHA)	+= pwm-airoha.o
>>   obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
>>   obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
>>   obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
>> diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
>> new file mode 100644
>> index 000000000000..54dc12d20da4
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-airoha.c
>> @@ -0,0 +1,435 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
>> + */
> Would you please add a "Limitations" paragraph here covering the
> following questions:
>
>   - How does the hardware behave on changes of configuration (does it
>     complete the currently running period? Are there any glitches?)
>   - How does the hardware behave on disabling?
>
> Please stick to the format used in several other drivers such that
>
> 	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c
>
> emits the informations.


The answer to your questions are currently unknown. Is this information 
needed for a merge of the driver ?


>
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/mfd/airoha-en7581-mfd.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/gpio.h>
>> +#include <linux/bitops.h>
>> +#include <asm/div64.h>
>> +
>> +#define REG_SGPIO_CFG			0x0024
>> +#define REG_FLASH_CFG			0x0038
>> +#define REG_CYCLE_CFG			0x0098
>> +
>> +#define REG_SGPIO_LED_DATE		0x0000
>> +#define SGPIO_LED_SHIFT_FLAG		BIT(31)
>> +#define SGPIO_LED_DATA			GENMASK(16, 0)
> Please make the bit fields's names start with the register name.
>
I noticed REG_SGPIO_LED_DATE

DATE should be DATA.


>> +#define REG_SGPIO_CLK_DIVR		0x0004
>> +#define REG_SGPIO_CLK_DLY		0x0008
>> +
>> +#define REG_SIPO_FLASH_MODE_CFG		0x000c
>> +#define SERIAL_GPIO_FLASH_MODE		BIT(1)
>> +#define SERIAL_GPIO_MODE		BIT(0)
>> +
>> +#define REG_GPIO_FLASH_PRD_SET(_n)	(0x0004 + ((_n) << 2))
>> +#define GPIO_FLASH_PRD_MASK(_n)		GENMASK(15 + ((_n) << 4), ((_n) << 4))
>> +
>> +#define REG_GPIO_FLASH_MAP(_n)		(0x0014 + ((_n) << 2))
>> +#define GPIO_FLASH_SETID_MASK(_n)	GENMASK(2 + ((_n) << 2), ((_n) << 2))
>> +#define GPIO_FLASH_EN(_n)		BIT(3 + ((_n) << 2))
>> +
>> +#define REG_SIPO_FLASH_MAP(_n)		(0x001c + ((_n) << 2))
>> +
>> +#define REG_CYCLE_CFG_VALUE(_n)		(0x0000 + ((_n) << 2))
>> +#define WAVE_GEN_CYCLE_MASK(_n)		GENMASK(7 + ((_n) << 3), ((_n) << 3))
>> +
>> +struct airoha_pwm {
>> +	void __iomem *sgpio_cfg;
>> +	void __iomem *flash_cfg;
>> +	void __iomem *cycle_cfg;
>> +
>> +	struct device_node *np;
>> +	u64 initialized;
>> +
>> +	struct {
>> +		/* Bitmask of PWM channels using this bucket */
>> +		u64 used;
>> +		u64 period_ns;
>> +		u64 duty_ns;
>> +		enum pwm_polarity polarity;
>> +	} bucket[8];
>> +};
>> +
>> +/*
>> + * The first 16 GPIO pins, GPIO0-GPIO15, are mapped into 16 PWM channels, 0-15.
>> + * The SIPO GPIO pins are 16 pins which are mapped into 17 PWM channels, 16-32.
> How can 16 pins be mapped to 17 PWM channels?


The text is incorrect. There can be 17 pins in 17 slots.


>
>> + * However, we've only got 8 concurrent waveform generators and can therefore
>> + * only use up to 8 different combinations of duty cycle and period at a time.
> That's an information to add to the Limitations paragraph.
>
>> + */
>> +#define PWM_NUM_GPIO	16
>> +#define PWM_NUM_SIPO	17
>> +
>> +/* The PWM hardware supports periods between 4 ms and 1 s */
>> +#define PERIOD_MIN_NS	4000000
>> +#define PERIOD_MAX_NS	1000000000
>> +/* It is represented internally as 1/250 s between 1 and 250 */
>> +#define PERIOD_MIN	1
>> +#define PERIOD_MAX	250
>> +/* Duty cycle is relative with 255 corresponding to 100% */
>> +#define DUTY_FULL	255
>> +
>> +static u32 airoha_pwm_rmw(struct airoha_pwm *pc, void __iomem *addr,
>> +			  u32 mask, u32 val)
>> +{
>> +	val |= (readl(addr) & ~mask);
>> +	writel(val, addr);
>> +
>> +	return val;
>> +}
> pc is unused here, please drop it.
>
>> +#define airoha_pwm_sgpio_rmw(pc, offset, mask, val)				\
>> +	airoha_pwm_rmw((pc), (pc)->sgpio_cfg + (offset), (mask), (val))
>> +#define airoha_pwm_flash_rmw(pc, offset, mask, val)				\
>> +	airoha_pwm_rmw((pc), (pc)->flash_cfg + (offset), (mask), (val))
>> +#define airoha_pwm_cycle_rmw(pc, offset, mask, val)				\
>> +	airoha_pwm_rmw((pc), (pc)->cycle_cfg + (offset), (mask), (val))
>> +
>> +#define airoha_pwm_sgpio_set(pc, offset, val)					\
>> +	airoha_pwm_sgpio_rmw((pc), (offset), 0, (val))
> That does the right thing, but I'd consider
>
> 	#define airoha_pwm_sgpio_set(pc, offset, val)					\
> 		airoha_pwm_sgpio_rmw((pc), (offset), (val), (val))
>
> to be more understandable (or ~0 instead of the last (val)?)
>
>> +#define airoha_pwm_sgpio_clear(pc, offset, mask)				\
>> +	airoha_pwm_sgpio_rmw((pc), (offset), (mask), 0)
>> +#define airoha_pwm_flash_set(pc, offset, val)					\
>> +	airoha_pwm_flash_rmw((pc), (offset), 0, (val))
>> +#define airoha_pwm_flash_clear(pc, offset, mask)				\
>> +	airoha_pwm_flash_rmw((pc), (offset), (mask), 0)
>> +
>> +static int airoha_pwm_get_waveform(struct airoha_pwm *pc, u64 duty_ns,
>> +				   u64 period_ns)
> Given that "waveform" will gain some specific semantic soon, but this
> usage is different, I'd like to see this function renamed.

I suggest pwm_generator. Is that acceptable ?


>
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(pc->bucket); i++) {
>> +		if (!pc->bucket[i].used)
>> +			continue;
>> +
>> +		if (duty_ns == pc->bucket[i].duty_ns &&
>> +		    period_ns == pc->bucket[i].period_ns)
>> +			return i;
>> +
>> +		/*
>> +		 * Unlike duty cycle zero, which can be handled by
>> +		 * disabling PWM, a generator is needed for full duty
>> +		 * cycle but it can be reused regardless of period
>> +		 */
>> +		if (duty_ns == DUTY_FULL && pc->bucket[i].duty_ns == DUTY_FULL)
>> +			return i;
>> +	}
>> +
>> +	return -1;
>> +}
>> +
>> +static void airoha_pwm_free_waveform(struct airoha_pwm *pc, unsigned int hwpwm)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(pc->bucket); i++)
>> +		pc->bucket[i].used &= ~BIT_ULL(hwpwm);
>> +}
>> +
>> +static int airoha_pwm_consume_waveform(struct airoha_pwm *pc,
>> +				       u64 duty_ns, u64 period_ns,
>> +				       enum pwm_polarity polarity,
>> +				       unsigned int hwpwm)
>> +{
>> +	int id = airoha_pwm_get_waveform(pc, duty_ns, period_ns);
>> +
>> +	if (id < 0) {
>> +		int i;
>> +
>> +		/* find an unused waveform generator */
>> +		for (i = 0; i < ARRAY_SIZE(pc->bucket); i++) {
>> +			if (!(pc->bucket[i].used & ~BIT_ULL(hwpwm))) {
>> +				id = i;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (id >= 0) {
>> +		airoha_pwm_free_waveform(pc, hwpwm);
>> +		pc->bucket[id].used |= BIT_ULL(hwpwm);
>> +		pc->bucket[id].period_ns = period_ns;
>> +		pc->bucket[id].duty_ns = duty_ns;
>> +		pc->bucket[id].polarity = polarity;
>> +	}
> One downside of the (nearly) maximal flexibility implemented here is
> that if you have 9 (or more) requested pwm devices configuration is
> quite limited.  So it might happen that a consumer changes the
> configuration for pwm#2 from pwm_state A to pwm_state B but cannot
> change back to A later.


Correct.


>
> If you limit the number of requested pwm devices to 8, the code gets a
> tad simpler (because you can map a fixed bucket to each pwm device and
> don't need to search during .apply()) and each consumer has maximal
> freedom to configure its device.


The main use for this solution is for led-dimming which uses the same 
timing among groups of leds. Most (of our) products have more then 8 
leds in total, with a limit of only 8 pwm devices it would not be 
possible to use the mainline driver with our hardware. I suggest that 
the current logic is kept but properly documented in the limitations 
section.


>
>> +
>> +	return id;
>> +}
>> +
>> +static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
>> +{
>> +	u32 clk_divr_val = 3, sipo_clock_delay = 1;
>> +	u32 val, sipo_clock_divisor = 32;
>> +
>> +	if (!(pc->initialized >> PWM_NUM_GPIO))
>> +		return 0;
>> +
>> +	/* Select the right shift register chip */
>> +	if (of_property_read_bool(pc->np, "hc74595"))
>> +		airoha_pwm_sgpio_set(pc, REG_SIPO_FLASH_MODE_CFG,
>> +				     SERIAL_GPIO_MODE);
>> +	else
>> +		airoha_pwm_sgpio_clear(pc, REG_SIPO_FLASH_MODE_CFG,
>> +				       SERIAL_GPIO_MODE);
>> +
>> +	if (!of_property_read_u32(pc->np, "sipo-clock-divisor",
>> +				  &sipo_clock_divisor)) {
>> +		switch (sipo_clock_divisor) {
>> +		case 4:
>> +			clk_divr_val = 0;
>> +			break;
>> +		case 8:
>> +			clk_divr_val = 1;
>> +			break;
>> +		case 16:
>> +			clk_divr_val = 2;
>> +			break;
>> +		case 32:
>> +			clk_divr_val = 3;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +	/* Configure shift register timings */
>> +	writel(clk_divr_val, pc->sgpio_cfg + REG_SGPIO_CLK_DIVR);
>> +
>> +	of_property_read_u32(pc->np, "sipo-clock-delay", &sipo_clock_delay);
>> +	if (sipo_clock_delay < 1 || sipo_clock_delay > sipo_clock_divisor / 2)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The actual delay is sclkdly + 1 so subtract 1 from
>> +	 * sipo-clock-delay to calculate the register value
>> +	 */
>> +	sipo_clock_delay--;
>> +	writel(sipo_clock_delay, pc->sgpio_cfg + REG_SGPIO_CLK_DLY);
>> +
>> +	/*
>> +	 * It it necessary to after muxing explicitly shift out all
>> +	 * zeroes to initialize the shift register before enabling PWM
>> +	 * mode because in PWM mode SIPO will not start shifting until
>> +	 * it needs to output a non-zero value (bit 31 of led_data
>> +	 * indicates shifting in progress and it must return to zero
>> +	 * before led_data can be written or PWM mode can be set)
>> +	 */
>> +	if (readl_poll_timeout(pc->sgpio_cfg + REG_SGPIO_LED_DATE, val,
>> +			       !(val & SGPIO_LED_SHIFT_FLAG), 10,
>> +			       200 * USEC_PER_MSEC))
>> +		return -ETIMEDOUT;
>> +
>> +	airoha_pwm_sgpio_clear(pc, REG_SGPIO_LED_DATE, SGPIO_LED_DATA);
>> +	if (readl_poll_timeout(pc->sgpio_cfg + REG_SGPIO_LED_DATE, val,
>> +			       !(val & SGPIO_LED_SHIFT_FLAG), 10,
>> +			       200 * USEC_PER_MSEC))
>> +		return -ETIMEDOUT;
>> +
>> +	/* Set SIPO in PWM mode */
>> +	airoha_pwm_sgpio_set(pc, REG_SIPO_FLASH_MODE_CFG,
>> +			     SERIAL_GPIO_FLASH_MODE);
>> +
>> +	return 0;
>> +}
>> +
>> +static void airoha_pwm_config_waveform(struct airoha_pwm *pc, int index,
>> +				       u64 duty_ns, u64 period_ns,
>> +				       enum pwm_polarity polarity)
>> +{
>> +	u32 period, duty, mask, val;
>> +
>> +	duty = clamp_val(div64_u64(DUTY_FULL * duty_ns, period_ns), 0,
>> +			 DUTY_FULL);
> DUTY_FULL * duty_ns might overflow. Also the calculation is wrong.
> For example if the following is requested:
>
> 	.period = 23999999,
> 	.duty_cycle = 8000000,
>
> you're supposed to configure period = 16000000 ns and duty_cycle =
> 8000000 ns.
>
> (I.e.: Pick the biggest possible period not bigger than the requested
> period. For that pick the biggest possible duty_cycle not bigger than
> the requested duty_cycle.)
>
> If you implement .get_state() in a way to return the actually configured
> state, enabling PWM_DEBUG and intensive testing helps to get this right.
>
>> +	if (polarity == PWM_POLARITY_INVERSED)
>> +		duty = DUTY_FULL - duty;
> This alone doesn't switch the polarity of the signal. Please only claim
> to be able to implement the settings that the hardware actually can do.

I am not sure I agree, but I will investigate this further.


MvH

Benjamin Larsson


