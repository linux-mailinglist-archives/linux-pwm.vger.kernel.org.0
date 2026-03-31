Return-Path: <linux-pwm+bounces-8432-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBQ1IhUuy2n8EQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8432-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:14:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9D3363609
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0FE930846F6
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 02:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1946367F5D;
	Tue, 31 Mar 2026 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VcdpV59N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B0366DB4;
	Tue, 31 Mar 2026 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923165; cv=fail; b=AFzX8aHpU+PNH03XtevzjiAoIF68Zpx3Z88iwX6p8WhbdUTemuqnhh+/aJWL+/BYNuCQHWz+NGsw5L+bkxmilCOPkWLQ3C5aXcw0AZopsm6cM7L0tOF6v9mp0rMInh9/sJzOS4XW7gj6pO64bK8qLiLLt6NhgCzQcCeEF0GoJ9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923165; c=relaxed/simple;
	bh=uTRqogwjKuWXcnXrAJ3lax53JDoFosbeDA7STMza/ck=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jVBO3PcIFe1lowtwPLrV6DzA1yPybtvneFtPUADOaLKBEcMYJmXirOXBVbpPT9yWSTN1RvGXAqZGiGFsIBMZYrVvEAa2+WhOuh6bZ4zmvzkygxZMHimLtyWrEqHfSndJtXEykwAgF0XrQOBll8NiAoJxHAVDRzMUUfEl0+1WUEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VcdpV59N; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVvggeXNYJOj2HhD9T18j8AQZ1D6l4sTo2cPZFFlRM3RG5IPsmYiBXOSRJ2A6N49w/M1gTcdxJMQHib4p59cEpEuMZYwJQKFaPrO/iaJn5OxH5yxd9SLLIpM5m6rteGjBlMVcXcdoQlzAILCQ/mwfNDZ+ouJANPAq5wDtOPRVXsshrGXOqxtAtEm10zoBJCv6myfwk/s7DZdnCJ2ngfBiSAB9opZf4tu7ENv7/9jm/qIvGA4A2X9ptz1dFh4dzED80/hgxzZtEB0Fo4CqEHIUCK72wxaEqUsHufDryisDdnQMwQ5Az93wO0ih6LiW3rJNcqfJNgNL9n0O99ZqdHsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPImkE1GWdV8WeYRws8lAyp6pPI8gFA2YVMajzjzaxo=;
 b=BfCOHMNb0UbJRZ3Iqh76bMHKm8Qu4aRy/760oBWmYEDrV0ikSIpcXBn07Bf39xQQepYmNQGA959RhgvVI9XjrBKbsRTkF9qXmQtPpVZGaDHElgZ3COo2EAj92drcdAM665Ln0qEeKnXIw1Iac75jWMY8ollyUzbaUeLB5DyyWlM50dQe7J9DdwBkZbQQ9N1cf7IpHLYkA6LlObqsFtx/lR50ayLJQkzx+2lU9wPoAfHzBm7maF2/NSGDlM+UVLCnDiyemoWi4QftTWMwRWpCRnhFeZYY5vkXh8xH2+nm7GwCNFvoIGbPjaqNgQ/b+cB8s/o8crn+3CT3GEsFWUZL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPImkE1GWdV8WeYRws8lAyp6pPI8gFA2YVMajzjzaxo=;
 b=VcdpV59NkZWdE3gQnm4dsLx+3FYAr1ZHstV5F+iVesFTNGbrY+//ZR6tGZOnS0Nb2/P7CJj6FrRZ7U5LaPm6NeF6N3ZIPIPKo3ru9ZnsKp4SQxyz2yH8MEhBFkwrQCePeEc7vaE5pIW1h161wmMLdPc816k5aJ758WWA+iTi76sPb9iCxUSRIfQlRpg0hkk5hXmnp7rnYpnTwsXRqRTYCE7D8+/i5OkQ70yLypQi7qKFzmqFCUt3atP61jinobzelQ7D369eQrjGLRpdbYUc3nAIimk3/lBrspiaeNELlcWudngN91TFVvREBn/I+4eFJ2acsDY958hFLT0Zp0gjpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:12:40 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:12:40 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 31 Mar 2026 11:12:15 +0900
Subject: [PATCH v4 3/7] pwm: tegra: Modify read/write accessors for
 multi-register channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-t264-pwm-v4-3-c041659677cf@nvidia.com>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
In-Reply-To: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9387fae2-b7b3-47a4-83f5-08de8ecafc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5l0SiFBMqAJl202Dy5zsBGq5X7kKSVK0sDjeuAPUCDTKyp26nhi9K6Zp95mAO4rI+NdeunyP2sb0xVDfkD3eiU1ComsMmdbUUas+QJFiX7OGRmKpPEbRj7MevQHaI51YJKJC6vhm+nrsYtqem0X0FUx/U6iGsmIHciCfjDgAvdhmE23a2V2klkFrti2JvEYdFARprVIjiSaeG0e8Guxc5mMWwwKpvtHboEW51E/TD4tOAP4gmcc+/XvfG+NQY73sMh1uj2H8mgCj82s62BzdgbFFH+77hcaVSxIA4RONodh49hdrpCSr6hSuVOlmZIl07WIUJ6rN5SXy4DKHDHRQ9Mkl/Ef7ftS9Oh2rV6+C0KAJfhPPG2QXRXLwkmqNmD4BSrOyrY6fxXdhhuHNq3ymnsi9h29bHNfIIU7iYsUzh6KXf8sjFKjoTmCor2g1l7LfocpllkmmTE5F9215w6/1wDdlvAV2nBDzDA9BJoY94G0bWHsSZtxvfhoXh5G1375U8YQffMhKb90IHdwSQIj0AupFsE+7C4oEKhQNgl4sDXLUPFia80NKUqaQE3EXo5dnl0Vlp55aqnix6OMaiNqbu9zM2pgzSNYRLOsq8DF/2hhxNXJ0NOqXZkKL3jozheyzV+suEkDoDdBaCNzA6/cX662Mk653S/EsK2brOKmeWU68PO7eVhOfCFxrLBCPwNmP3+bK2y1K3QBO4qPM0Pn8rXz28+Gua4v7t/AweIK+P3E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk0wS1JoaUVDZU83aTFiR1QyWEFqQU5oQUJVMExuMXdNSTROMGtQdHRZUGh5?=
 =?utf-8?B?WlJHd1ZiL0lPaXBVeENrMHgwVjRQZUVNY2xZdlRjTzFWdEs5Rk9IV2VvdHNu?=
 =?utf-8?B?cEVxY1piOGhkTGt1b2hsSlRnbThxWlptcFJFbW4yMkVaekZBblEyRU1ubzBN?=
 =?utf-8?B?NHZYbnd5TTQ0RmFGT2wzNVJ4b3pzWldLa04zMFZ4V2pMaGltNWl2bnFNU2kr?=
 =?utf-8?B?V1Erb3M4NmkyZWhqeDJHeWMxNWlnUGFnQmhLMlJuamw1TzhhNEJ2M3E2dE9Y?=
 =?utf-8?B?dWlUSDVWUGFqU2RLYUovUnptd2hDN2kwcjZRWCtWcWRHbzNaY0FDcHp6SVBW?=
 =?utf-8?B?RVhXS1lQSzh0SElQVnJsemF1RENHODB4MUVFVnV2a1lyTEo3UW1kd2szVGxz?=
 =?utf-8?B?eWtJL1REdUdNSU93OUR5aFZ3S1A2VkYrMGVqcHB3WFVUNHgxSTJBUmdnN1po?=
 =?utf-8?B?ZjZGaTVZbVF1R1ZMcVBxUkJxUE5DcU9yV3RUeUVDVmM0ZGVXQlZEcjROT0VK?=
 =?utf-8?B?ZytnM2NUNVZ0eksvRlFPcnZ3ZmJ0d2ZYMkJyTUFHWVFxbGNSZ2wzYWhiS1Vi?=
 =?utf-8?B?SDZ4cUxwRWRWbTlGTlB6dzNTWFFPVHBkcFB1eml6V1BsWHZxdW5YNUZjWlVX?=
 =?utf-8?B?a0xXaFU1dndjWWVTODhGbmRpdmlVV1hMZ2c4dDN4MG5ZRUd5YmxaRDJNc3RW?=
 =?utf-8?B?VXFCOTVqQlJ3K0pZUE1nQTNWR3phUDFPZnBRVmhWQUZOMjk2SjlKWWpLY1Nt?=
 =?utf-8?B?S21KREJLZmJRajBkd29EczFIZUZxUXhtS1IvWUtrUk1qbmlOa3MzUDM2enJO?=
 =?utf-8?B?a2kwL21wRkhWL3JJYWlkdk1KZjdaTk90RWgwdDJFOHo4bncwNWNNdlN6dFZL?=
 =?utf-8?B?YlpXN2JUYlovd3Z3b2xLT0hPalQrdUFjcWJRY0FHejFlM1N4d3pxVlpFL0FV?=
 =?utf-8?B?Uk9SVTBINHArZmhQRGN6eGtnWnVadkZjZGlEU1BaL0lEL1hZTUZZaGVMTDZ4?=
 =?utf-8?B?Z0lBVzRXTGFJQlJjNFB2Q3hrNlZiOWE3K0VmN0w4TGk4TVp3WStzQjdDZElO?=
 =?utf-8?B?dEpERTl3cVdzbDMwQkhEUGFQZVVDNDhMdXRLci9zL01jM01VL0YxMXFhUjFC?=
 =?utf-8?B?MExQUSsvb1pnektCR1ZOeVhrRmMrZExxdWhIQTVSMkVkZ0pzZEZlbU9YOFNT?=
 =?utf-8?B?ZStwQno1akJRWTZINzZnTVVQV0VkcjhOa0ZtNURoeEtscHhwVEx6OENveDB6?=
 =?utf-8?B?OVJ5Vm5kZEw5OVVyYS9jME1Fbm9pbkZ6SU1SRkhlWEwwcUtDR0JRQmtCeHQ2?=
 =?utf-8?B?SUlQKzVqbGZEQ0N3Vm1FL3NQWmJYUEFyMmZJc3ZZN1VTUkpNY1pIV014NUVY?=
 =?utf-8?B?MUZwdzdQeE9QVGdjRHdnUnU5d1UyeHYrTkNUSitpWDFQcUhRakxFSVdlK2ZH?=
 =?utf-8?B?NlBrNUhBZEJEN0VKRi9rUkxBTHd4L3pUQ1g0aEI2YWo3b3NvbVZrMWdnRHZM?=
 =?utf-8?B?cjFTSlQ5djBsQ0QyZjBod0xIZkN0WmNZMTJpV3BNbHh5UEk1QjhxV2g2TmRS?=
 =?utf-8?B?a0YvaDcxaW5MeGRGMTdXMVhReHNNRVpzcUhvNGF4cGR5ZVFUN1hsamM5MzQ3?=
 =?utf-8?B?Z2d6LzFvZ2d2cXBXT01UUVBwOHg3OWkyOWdVdE1xelBBcVdTZlU0QlVSRldC?=
 =?utf-8?B?VUpVd1VkamIzcDY4enBQVnk0SS9BK3lRc0hwZkJvWUQ3Z3BqenI2NVFOMW5M?=
 =?utf-8?B?VnlnWmo1UWNVVUNtdG5JMXFtYXQxRkk4R09pL3pucGRRYUJYMkIyOUQ1bkx1?=
 =?utf-8?B?TUpxeUVtdjZnaFc1WDdvYVVuSTA3bHVEa3E1dFowVGNJWGIxckc0bHo4TXd4?=
 =?utf-8?B?VCtwSVJMOEUzUHFYM2M5K0V6L0V2dzVsWFY5TGgvZTFqSjM0NWtUL1lVL2k5?=
 =?utf-8?B?SU8yMldDSzRhOVBmbmp4dVpreTVVcWF2SGxQNGxiYzhpYWgrU0Rpb1hiR2h3?=
 =?utf-8?B?dFNoU2FENXhrZXI2V2lTb2xrRE53RHAxSFoxK2dqNTdkMU5ZbDIvZS96dTNu?=
 =?utf-8?B?V1k5WUFkZFU3eWRJTmlSUEdScDZURE8rZitENkMwaldvUG1DUjc5cDYrWGZL?=
 =?utf-8?B?U0JIelg0SWhUWG4wVHBmK3lTbUowek5yYVljZWxpUFBoRVhNY0JYUE05VitF?=
 =?utf-8?B?NFJRM2RNUk9Rc0NqMjY3cGJYSHFKSnpicGF5RlU3dUZxbWJuUTNRR3dKTjRs?=
 =?utf-8?B?bmhaL2s4aUZMQ0F5SUF2cnMzQ2J0QythUlkweTNSWHQ0MmgySHdEQ0txRk1u?=
 =?utf-8?B?a2pmVERIclhvM0p3dyttTmxxakdGV00rNEZSR3JpcC9uZmo5T3ovN2ZDZ2Ju?=
 =?utf-8?Q?n1XApOlzcA6EhyYWY4eGf+JSeGznQBYB3lV62JaDPaqRN?=
X-MS-Exchange-AntiSpam-MessageData-1: iVIhX0Yf0tc1dlr233QgMB/+zjjO4zSvyJU=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9387fae2-b7b3-47a4-83f5-08de8ecafc75
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:12:40.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpFnwxBb4xmCztSwLrGew4N80iK324bAXVA8Q1UtAQAF6uJC9rirShvBrrP9g6hytEK7jux1B58TKtKFV6MJQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8432-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA9D3363609
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, each PWM instance has two registers (per channel, of which
there is one). Update the pwm_readl/pwm_writel helper functions to
take channel (as struct pwm_device *) and offset separately.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 8a330169d531..358c81cea05b 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -57,6 +57,8 @@
 #define PWM_SCALE_WIDTH	13
 #define PWM_SCALE_SHIFT	0
 
+#define PWM_CSR_0	0
+
 struct tegra_pwm_soc {
 	unsigned int num_channels;
 };
@@ -78,14 +80,18 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
+static inline u32 pwm_readl(struct pwm_device *dev, unsigned int offset)
 {
-	return readl(pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(dev->chip);
+
+	return readl(chip->regs + (dev->hwpwm * 16) + offset);
 }
 
-static inline void pwm_writel(struct tegra_pwm_chip *pc, unsigned int offset, u32 value)
+static inline void pwm_writel(struct pwm_device *dev, unsigned int offset, u32 value)
 {
-	writel(value, pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(dev->chip);
+
+	writel(value, chip->regs + (dev->hwpwm * 16) + offset);
 }
 
 static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -194,7 +200,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	} else
 		val |= PWM_ENABLE;
 
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	/*
 	 * If the PWM is not enabled, turn the clock off again to save power.
@@ -207,7 +213,6 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -215,21 +220,20 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = pwm_readl(pc, pwm->hwpwm);
+	val = pwm_readl(pwm, PWM_CSR_0);
 	val |= PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = pwm_readl(pc, pwm->hwpwm);
+	val = pwm_readl(pwm, PWM_CSR_0);
 	val &= ~PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }

-- 
2.53.0


