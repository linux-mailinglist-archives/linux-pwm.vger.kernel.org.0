Return-Path: <linux-pwm+bounces-8347-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD16KR4XwmkHZgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8347-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 05:46:22 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D303020D8
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 05:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1802302867B
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 04:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584921DF261;
	Tue, 24 Mar 2026 04:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PrTvJnal"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD3E573;
	Tue, 24 Mar 2026 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774327579; cv=fail; b=ned8f2q1RNYKd9vBM0Y6uJv3HIn4UDYrkjWs+/pdeh0Qsdw3IqdsI6LVwGYMgqHKhYhT1gTuEVOQPsegLPEGHhPgO41Wj3H3gXpR/ZYa1iIcaej2peV/0sCoFZHO0wBZtckaIaqbEQm55PmyqquexlUFnpaXFa8Om813gAy3fAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774327579; c=relaxed/simple;
	bh=UifJCAcALMB5HPM0j/rIl4jvLzZy9xAj3pPRvMsKV/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kj8gTMKZxBCbJTw594uWRwsDx43MhOoIQ2nr6R7N0mkV8Dips8juGajsueKknBHhDCWH0cjFDU5D5tkGWkXZgQV5TKH8tVLEy/whn28miSPjIFtYaRkwymnOcfAJs9hECmiiEHGbKbMdB7ntGtMvL4XhuhuBx7arqmn+x3TiWEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PrTvJnal; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUCvZK6R7/sewOOtpfe7+2NR8I7utQpCxJ2lOuQVAOZuZT99JEe0M2PfTbjtj45g4oZ89XFq1JcZtP7pepCjuxpupNt2rz8Y6P1RMOV3CDvzhezZNgpAIObSwH6AKPoA+SvPnX2k3AAx2ZUXhCWeamCvkQ6BlIRd4mmrrr5xP3RkdMDiJMLaXGPh3UZOh9f3FuwhVrk1r6zewLe6V0oxEDWjiA0i5zeHRpqr0Mxt0VHrM9OliGq5TDt54SeIk+puu5x6orgHPSc0h3FbtLyYdtuzBQ7iPSZXJywvtpvWdW+gqrPAeFPhTRcWU6dCqaLDmafhFmVdfxwAFIAcSXl/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ikgybo9w2gKdvTxAq+CVxK1Lfj5awGkm/fQqQI2az+4=;
 b=NEW5rQ69+kappaBpcJnIzD+jwG2xbA5pO+ZR6rhs7bkpAhlWoszjA/2jmeVDMJqRIFrBsZnqusgLxkOPPulbu/6mpScRs328/WgUSxTMS8nrDF93ZdLQLqVWdfK/56VJc83WqtaDA2cqcVmpwIm71K1mVq5CQio+PhmR4WX+UW+cWkBFR//EhuEeGFYS2UbSqIolEg5mJ/4/BW902RqObYR3Gh7WitxJgJ0nrlvhEs/UnA4xrSr2wUCCWuuKaikvFFAjp4Pj6gtLHDjOU4ZBu8QRb5yiZAt0YsC5JtjK85EpdXXSYqObKioknjyBeyGbMHlT1qRQoKy9RRMUFNSUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ikgybo9w2gKdvTxAq+CVxK1Lfj5awGkm/fQqQI2az+4=;
 b=PrTvJnalOZa7xrrqavJ9YaDwpjRCQiWjwjRO4+9DrMsIRbe9sqbXJR32B9qra9rfZylnHy66fg/R8fc6MrHpfamves4qcDj6Ne5yek9cBb/HN/JdGDZbckx8VQmeh1OaLV6LjUN1p7uw2d03UdQSAzgNZjCuh4lNw2bjpHgT7+lU6+5SfR1IrYT+vjkBMDrLHRHsAjFAfjt6cCHinCIg0LcU4apzjcd+WvteXYCnaOjuyZXvPUXZ1LlIlQcwiJgT8Y5ZRjCoN/q4xFz5cEwjuVoofEWSlfD2iO3fXcxzHx4hkSSE1y6U/kj2cQYpXdg5/2OwzKnHwI4+UkYcNNHTbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 04:46:14 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 04:46:08 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH 5/5] pwm: tegra: Add support for Tegra264
Date: Tue, 24 Mar 2026 13:46:04 +0900
Message-ID: <14407093.uLZWGnKmhe@senjougahara>
In-Reply-To: <de5e6159-ae89-4b8f-948a-678cea9211fa@kernel.org>
References:
 <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
 <20260323-t264-pwm-v1-5-4c4ff743050f@nvidia.com>
 <de5e6159-ae89-4b8f-948a-678cea9211fa@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TPYP295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: d457de48-ecf0-41d9-0d8f-08de896043df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AJlMih0l83FTyUdBSIbzuwdHqPrhch2XOgkzkOUbQxoPnMyPmLpazXqTsB84LJmW8QLwUPtyeGeyyyfQwOoGOUwvqCoxDSEtKTSXnLHYXkOMPGQPgtKsvY6PiYOrdiBZ62wbl5K6wQQxqOHRyTWjfKKBh3dpJP38QJPt89XdUt57rVMjOC9Tt0w6AQh4AZnGUo/OIAuXTZCpzW6fT7syeZ6qyR7FWRCyeCMB9qhB4d1emrVNNV2nXHTz/L9bPiYTYXXkAN6gYw1omJ+/pdeMXikSMFA6LCkkhzNBiY7YP85KG+iKPBNS98xAPzQ75p5x0pLxuYCbM89THYo+CDqT8ykcOXQQfmK4lCukiNVdFoOXvpOhIuouzsAL11f28oglMaGMERt7HD+glpa8K1mPv9azUfK0cplAjTd0kZ7CBxs7ICRbOsP+g2BXJnJkdzqPDbVJmzBXIyCA+RGMCYijZiX6/so8ES/2sHglcCsoiKdNyY1PvaQyg714LhxKz40yG37GeuYNDkr9x5qrW4kipbWBn7WVNxAqZmRO0OqYxlfD5AFSdWmGTYWm2yPBVPPO4mHWSKIzmtLKjCsRPP9ivHhjIeILk+HoxYUvIIN1m0yxQZFnwMgevq3M26dUzqPJe6Y/XLdHSUgayDyolMkC8T1aJPMWAbhk+xwWv5dfr9LUtcEqOzysS9ZHoBAolc8S4kj7NHva6g6495ePcG8iNXRE4i7U7FY7ByR3WmMxbuo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTkxUmJUMHd6MFMyejNYU0VlbVE0WEo1a2lReWpaUHMvQmhMeVQ5d1dRMkUw?=
 =?utf-8?B?d3hzM0JNMytNSHFlTGRsams5dDVoTkVoOVQvbGF3ekJsK1R0UnVuUXpIalNJ?=
 =?utf-8?B?VW8va0FVT2d3cVc5aGllVXFadmI1MldmU3NMMEk3VkNrdVBRYVYxV3Nyczdu?=
 =?utf-8?B?VVFhTTYxMUM1UmwreW1xcEsrZVR5cnJaU0ZEL3kzbEp2dHRxamEwdE5CNi9N?=
 =?utf-8?B?OHBnSkZFRVlUYWxpcy9KZzRMMGVwY1hkK1BIKzNPaHd2djVhVGRPQkpuK0hq?=
 =?utf-8?B?UVo4NFBKZ3Y5UGlrcjdEYWR0RHN1TFlqVjFXU2VxazBsdzJpQ3ZMUXBXNXh5?=
 =?utf-8?B?TVNIaXE5VkdWaVdBR29PQkdOL01La2h5MVNIdWZzemU2VVlMYVdEU2c4cXVi?=
 =?utf-8?B?WWhMTHhiZ05NQkpsYzd3MVN6bmdBdG1oVUJEWTBlcUdiRTYzMk5xeWUxazU3?=
 =?utf-8?B?cFlZVFZpUmxiNnowdk9YOFptWnNFQ2VxM0Fva2xHRzdLSHRJeWVJdUlvUXFK?=
 =?utf-8?B?bWkvdkpUM0Y2SU1WZ2p5aHJqL1cvdUhkUjJ0S1BqUmd0djdRdDZJT2NqU1Zw?=
 =?utf-8?B?STFwOFZzMlhFV1FONEgwRmdTMlBKbmtROEhia1RuZXhBczZlNzdHcm1TNWU4?=
 =?utf-8?B?bzBSQU9qZnB0RzRvcDYvMHUvb0x6cGVyUHVSbnA1WStBTHVpVm1raGRYWVc0?=
 =?utf-8?B?TUZJcnFDVUZOSEZtMzVaSGtCbldpSUt6ZEpUdmRlNEJUSG0zODRDLzRFY0xo?=
 =?utf-8?B?WVJidEU4c1cxM3FnZk1aZjZRTFhtaFMzOVVYbndEUmRoaGs1YmxkQjJLUHNI?=
 =?utf-8?B?UUpaNXZyV1loRmFMaE9lWU10UndRblRKZ3QwQmdlUnZFdjVaQ29SOUFRTWJu?=
 =?utf-8?B?TnpsVEdBaWZBazRDK0lad0dlTTd6Z1g2VlpVWUgydGh6eHVDazg2ZUVtUktZ?=
 =?utf-8?B?OWl2QjMzSDh4MFBnYTVSNEJIMWVJeTJyeTJaWmdOMjlTL25wMk9reTJlOXhK?=
 =?utf-8?B?aTFNMk1SZE8wQkU2aDlNMW9UUnBwdW9LTTlpV1RSdE1WNDFxMktyVTFHVU80?=
 =?utf-8?B?VldnZ3hHc2t2bG9uaDlmY2dMUU53YmJ2Q0hhckZmU3pGTFJkSFBYYkxLT2Js?=
 =?utf-8?B?aUJORnN5UmxXRXVoVDgzazRWMzI3a3ZrK2V0eHBUcHh0Ny9JbkNlUm16bUtt?=
 =?utf-8?B?TnlHSERld211YzAzVExrU2tVZ1RsdkJ2d09CNjNpWlBqZ3U3VUhsODV5VmZ0?=
 =?utf-8?B?RE1MODBwZE8vT3FwQ3JZRksycHNJYk1NVmxpYmtRRUl0dUlWeEw0OUdQS1lB?=
 =?utf-8?B?c1h5WGpES1pKZ3BGNVlEbTVsTEpHVnp1bXlLTTFLbytLd0x4TndrYUJyRDVo?=
 =?utf-8?B?YTZ3Y2RHL2lvVzRuMysrSENOamQ2V1ZkeTc4TjkyWjFJNm8rVXlYRkJubDJn?=
 =?utf-8?B?cjFRSzBSWEJWQnQvNEhwMFp2ZHdvc3N4MUNVRmZkbGdqcUdFS3BkQlBQaG5o?=
 =?utf-8?B?YmIxanVIeTZVTWxtVHlvQk9sY0ZWb2l1R0ZHSjRtVWYxTkIxUE1SUkNlTVlM?=
 =?utf-8?B?dFk2aWxkNzk1Z2FNL2M1MmZQZzYxZ1RDSU1kRTZSTFprbE85M3ExV3VhZHB2?=
 =?utf-8?B?NFl0TnZlakhQTEVhRE56Tld6WWtuSjRVaUh3Sk41dkF2aXplRjZ4eHFwWGw5?=
 =?utf-8?B?eFgrSEE0Y0crVForUU5xWHY5UnBZYnh4WWJ6WlRTaE9NWmhLV2R4OFBOU0Zh?=
 =?utf-8?B?TVJwVHlLcE9sRTRQN3NGemt5Qis1cmxNVlFUVndTTHdhandmWUVzczV3cmNS?=
 =?utf-8?B?L2s4V2NYSmVVOUVWcjRROVI2V0oxQXptS3hubEZwY2czQU1lVUgzWDhDaVZa?=
 =?utf-8?B?eEU2bmUrSHpwZTFhSlZPRjhSZ2o2ZXBYRHBCa2R6cm4wajlsSzVSZDhBblBF?=
 =?utf-8?B?c3huOFRqcjRIQkxvdXdIUkl1MHMwcnRrTDNjSnJBUnlnaFRzbHBRVWZLVkkw?=
 =?utf-8?B?V3VUbWpPVXIvVXNnWnhJN3JvbFFJSHJMdEErblRnWGhCcy9kZFpjd3RBRWpo?=
 =?utf-8?B?VXd2WGRmWVQ4cTZiNTFBSTBDd2J3d3NGUEU2N3YvampMOXZNY2VMakhPd0FL?=
 =?utf-8?B?emRkeUVScm5DWmZWSkU4OWN5M0haeVpYdG1ORG5HMGFsdWtEUzAvemF6SXln?=
 =?utf-8?B?NTkzRjA1V3hGSmFEUC9xZm5VNjRxZFpaQXdEQXh3SDZHdjZySERVcHhoOFpB?=
 =?utf-8?B?YUZkUzNFMEtIcCtkS3Y2bU51YktKRkpFc3QwYlJGRm00TVRya3lHd0tTd3hk?=
 =?utf-8?B?Y2FidGFteUJiamZlYUdiSzRrTnBsbGNoc21JVnJFMTVoQm04YU1paEJsVWto?=
 =?utf-8?Q?btjKYAetpK3ysqMpKS9GYj/W8H95Ibe5nqmm0WEiLs3Ka?=
X-MS-Exchange-AntiSpam-MessageData-1: I2pu29fTwZxw1w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d457de48-ecf0-41d9-0d8f-08de896043df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 04:46:08.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whnI9woU1gFnl1SBM1Fo8yQNcWTDW+lRA/huv7hcIJEJkmCvIJaa688ATrUXJpwOsD8HeZhAP+VNMf3PMaJ19w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8347-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21D303020D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Monday, March 23, 2026 4:24=E2=80=AFPM Krzysztof Kozlowski wrote:
> On 23/03/2026 03:36, Mikko Perttunen wrote:
> > +
> >=20
> >  static const struct of_device_id tegra_pwm_of_match[] =3D {
> > =20
> >  	{ .compatible =3D "nvidia,tegra20-pwm", .data =3D &tegra20_pwm_soc },
> >  	{ .compatible =3D "nvidia,tegra186-pwm", .data =3D &tegra186_pwm_soc =
},
> >  	{ .compatible =3D "nvidia,tegra194-pwm", .data =3D &tegra186_pwm_soc =
},
> >=20
> > +	{ .compatible =3D "nvidia,tegra264-pwm", .data =3D &tegra264_pwm_soc =
},
>=20
> Undocumented ABI.
>=20
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
>=20
>=20
> Best regards,
> Krzysztof

So, this series was checkpatch --strict clean (modulo one false positive) w=
hen=20
I submitted. I agree that that is strange, so I looked into it and looks li=
ke=20
I had an old processed-schema.json file containing tegra264-pwm, so checkpa=
tch=20
didn't complain. It is of course in .gitignore so I didn't notice.

Mikko



