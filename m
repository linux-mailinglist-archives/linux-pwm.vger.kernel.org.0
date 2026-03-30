Return-Path: <linux-pwm+bounces-8410-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHuzNQI9ymnD6gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8410-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:06:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E25357C5B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F4BC3000BA3
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58A3AEF27;
	Mon, 30 Mar 2026 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tJH8w7mu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306513ACA6B;
	Mon, 30 Mar 2026 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860841; cv=fail; b=YUw1T61jmOjrmlTTtXtI7OZwajLdR0vUsyRFzGMeX7xVYUxk3yyzMT8BGrwFwqhrYcvyt6JspfDd3RQCwgLjkstCtdOxyHjpJSFBthLDubTj0HZVuwUiHfK7WvktHabwp3uNnGdcx5FmoATwdiDMeJh/N6L9q4oMidiLmpSgSyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860841; c=relaxed/simple;
	bh=hegrrnhP5o41VUwRV47J80qEngzqiEb+lJhkWfcuwXI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ryG55/G8zexeL1kkE0Avzr5Ba2ydpb0lWdQ0AT05Om4XD3G4sxh+mMzySXJAUTqYZ9XHt4jPb3xkh3pjfOnvS9nSsK+VIa64rDL36SV9x6zSErv7uwmjOmHAuxRdwUxNDXsJ+K4M+drzBe6O+sCK4Fr7Kj3lLaFS3pQfmW2Eswc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tJH8w7mu; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwfHXN1w3bNzrJdzgwdhbh98eFYVyNpuLUUlj1yqR3cYd9s5EOqmh6jnsePm1TzL8uWRiCO+4MT3K+35AeocvOPCm7tSqv1FamJ8LX9/wRLxYVgPH8f37VxgCrPg5MhfUZhsdv+tCuPp9kFEgkbDgwxo4wS5MElsjl7Noiha0E3ExwhXltNgPbmgqYnwo9/3Rm2/IHQKBIrVMiqcrWbyESWnOshZG8jgVeEi+Sn7zsIFxPjyS8JyJWYc4m1PKFyKYAkVHpB3xGpK2hbMBr5VMinXMc72G1E6zrAvN+pOOcN3BjfKiZSnzcGHbzjCoZ02kgzGzkIv/HmeBlO7PXblXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utnqf1OSQzo1HfP526doitTSmqisp5ZLAmZnCFT/ZM8=;
 b=hG/j+RTV32PAHz5kkNAoiCaBUuonFORbVDy0HeNzU6Uf06LjFJG6oUrwKfqXUeTFexP/jlyrj+w/Yw91RgKRq43EaUc355/ziHd1UUQg8gzCWEAXYxxqkhCeapGAIDdCbc1hDAd0nHy7jtLXpppYb/WlzSZiSH/bpfCEUo2sSy5GU6ij1C51QwYY5trqVWjI2P79Jp3taZifnBrL1uSnSB9KoXibioaIU4skfxJX0Ic3yFMWK9IG2yHns95RYAdB2raVP9NGR8O7jyDGIkJLreS0jxy5VRJ6xu2GwqRLgcaEf/huEs0LpV7gwHK5lvOHCQZknSPWVcTfi43pTPM2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utnqf1OSQzo1HfP526doitTSmqisp5ZLAmZnCFT/ZM8=;
 b=tJH8w7muwm6oWDH6vCqBGIg9uihMvazPx0o9BxQpRVj77vwbE0FlTjLOGQ0PkoJv/vqHVr/XcZASGMFTS3R9Qtp3PlISv8Hi0cMdR30hSm+uRDFb68Isnb39dzwzBerk6B2Hj+c7tJrftuLNOPQDIdaO5dz23SwC2iAh5v69aNM4QrGqZqi52r4sIq5lOJVF1yeg55vpil/oqbRlop1PIwzbrhnpW0V7hNByryEn0wtZr7bTqDGvfhyoHttY6fgXtxoWh6sNpZF63sVxWQmSbhbv3w4d+MhHOLFKGGSMEwSKakZkZ2vrZajRyeABYaAMYpEjQUjPqwxV0bPjtF8V4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Mon, 30 Mar
 2026 08:53:56 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 08:53:56 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 0/7] Tegra264 PWM support
Date: Mon, 30 Mar 2026 17:53:49 +0900
Message-Id: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMOQ7CMBQFrxK5xuh7S2wq7oEoghfyiyyyIwOKc
 neciCKU8/RmFpJ8RJ/IpVpI9BkTjkMBcaqI7drh6Sm6woQDr0GAoDOvJZ1ePVWNZ+BAGBcYKfc
 p+oDvPXW7F+4wzWP87OXMtvUX4YdIZhSotDKERgpQEK5DRoft2Y492SqZH011MHkxjdFOa2W0f
 Ig/c13XL0j+xW3bAAAA
X-Change-ID: 20260303-t264-pwm-57e10d039df1
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MW4PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:303:85::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a10be81-3ddf-4665-4f5b-08de8e39e042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AzyXy7R9VkKg8Nl09SMAu95zu2hZxiPQUx2XNXfilEF4bl4W501i9uoAXFmpV5JKO2JW2QZQpwJHrLpCvNdTHePXZlfXQ16ipf6DQR5hOU7u/gPERsCsBzRigdTfsyDjZD2DuZSUZlYtA01CLjl5F5mpTmjdESzKC6eSK1h14Y9Zji5qDhQcOQhNDlEWLnlBJdEnfzwYvKkom8eqOwroUdTfwg0esTyC1qcp/2d2PU7KFckWWB3vXRIGJ9Lk6YOkoP+nOgqEyuMLDbyfZX6ZmAKpyrp0n8AcKghAwsnPovpMsy08rwy0qDoF6QaPldvGsF1Ls2+J57rE/w4O0R5II9yN0VYF9FBuf/oTTgfAMLCJ1YagxJQ50tR+zRxLwx8Ao71z8XXQ2Gi77EgjhwMyXFMJsLlqEArOUrr3IaRWNjufeDZS04A9VwUb6ePbAPm3fW/RlNGkWQxp5HSkEi2fps3y4I+t/rrEG5aQeHSKNtVGT3NoU4uRJu+854LyZrQ8HMhjWPIhMJLtFOhkJDnaHxdOBslHjTAk13h5+eATD8l8JcPLSgL4eqq5+t2RUSatd7XqhsYqWoj73J7ZYJK/0w7/oAwd+Qfk+JwEx8K1+oCCjzz1cqSXasGuOQ5ULGhkU4LMujTZguzUejLBHlMWxxGsQ+8PWJOpe8qyxqPYIT+mmCN4OouVzkz8JJW161G7XtiTY/SphGoJe+ZWe83LJsqd3uWMRFR/+t6iuIy5hqz3E7prV8TFBy1J6WZ8v4fI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3RXMDd2a253MmtwVjRyTHd0SWV6TDY0UFo4Y3h0N0YxdmZIdmlENTQ3Znpp?=
 =?utf-8?B?NXc4Y0lwNlRsVCtTdWtETnFYYy91N2k0WDh2TDc5bkF6dGlMU2Nsa3ZhYWFy?=
 =?utf-8?B?dG1oRzlma0tCZE9SQXNEbG9EWEdmRm0yQzJ3TTJpZ3RCZTMxWCs4R2krUldP?=
 =?utf-8?B?b2dLQTZlMmpsZ0p5M1RRN2JMRTVuNmJPelozT1lqUG4zaGlNQnAzL3VmL3dq?=
 =?utf-8?B?ZExxdExaekNzTU0yZG1zR1AvTHhtWWRUY0hJTGhhWHFvVDF4VHkrdXYxK2lm?=
 =?utf-8?B?c0Z0RW5zNS9kL0g4KzJYTndFSHZ5QjFtamlZTmxZNWFENzBNK3VTRmtVdlVD?=
 =?utf-8?B?NUphVHJTQ21ZUUtKS09kKzhySWd1dURKN05ndlo3M09GRTZ2c0YvdENiWGxu?=
 =?utf-8?B?QUZqWGQwYUJ0eXdOaURGYytOM1U2cjJHQTlzZGgyakhCNEFzU2VyWkZzdVNi?=
 =?utf-8?B?LzZ0Rk9HcnZWU1hrUEt4NHRlaGxwdzY4YWhBR1hBQk5aeVFINHJjUFVFYjRM?=
 =?utf-8?B?cThOTzNpLzh3aEUwYjBBMm9WZkxEdStaUHhOUkRuUVFabW1PTDJjNkFvVlh3?=
 =?utf-8?B?YlUwMlZQZXA3Y2RuMVpvakZDejZhaGxMTGYzQWJ2dFJMSnoyT0FsUWNhcWNv?=
 =?utf-8?B?azBia0pVNmloRVpVNE9MWDRreFVoU1NyRlA1clRVclRBQVdVUVlWSTkrdjgv?=
 =?utf-8?B?QTlNbnpYS3o0dW1nQS9qMU5QZ0NORUlkRVVkNGI5Mm1rWUdrUmR1NnlRWnEw?=
 =?utf-8?B?TVFzM0tMR0U2Q2JiemEzSFJJT1p1TVlUM2ZUUDdGeUFMZ3VwVi8zdThlcnow?=
 =?utf-8?B?NkhKT1kvVHBjbzRSdEwzeGxGbmVxTUp1UzdYUHlOVDlxcUJBWU5qL3JVWDBq?=
 =?utf-8?B?NUFvbDBRZ05NWUlIVzMzVVZMT0RITXc1Tkg0SGVDa2p3eGJuTmo4RnIrL2lj?=
 =?utf-8?B?MHpBajdaTUdIb1dnRUIvYkR0MjRhTmJpdC9STUxPWDVQSTV3RlFoQkxFdVo1?=
 =?utf-8?B?eEZMRHhlbUs0ZFh0azRSVDgxK29rTVhuOGJaaldMVExwMDdvVWRXYmYwOUxJ?=
 =?utf-8?B?ejZRa1BzZXRDeG9NOFk4RjZycUUyZFh2WlhnNlY3VnVOK0xodXhYbkVwbWJt?=
 =?utf-8?B?b0RhN2JsMFRkYkxrUEo5UVVFQWRFNllwaGJzRy9zK0R4RGpsMzBEdDZ3b2pW?=
 =?utf-8?B?b0ZJVHMyQ1BGbXVtN0REWXJ4MzQ3Mk5iSFc3a0ZJWEhuMTdUbDRNT2xoTVkw?=
 =?utf-8?B?ZFRxYTBYOVhvenFvZmtUYTRWeGpGb0piYUpRT0hYb3RhTjZ6MXF5cFVvYitB?=
 =?utf-8?B?R0FhQnFTTkZVWHY0djdJMHI4Zm9meWJxS3hKa2ttdUhrSjZsMCs1blBVb1c4?=
 =?utf-8?B?SU1Famw3bEVYMlpFejNYV3lZZzUrSzlwRWdpK2hVOWN4K1lMOVlzSWIycVR5?=
 =?utf-8?B?Z0hyTVk5NXhYSkNIVTNuOVBCc0pzZElrV1UwOUVkTHgrSlhjTkhaR3c1SFBF?=
 =?utf-8?B?UlNtZHNCQmtyVzlVczZrd3JLQ1h3NWRkclN4NnFPWnRlWWVvNG5KL1BjaVZ2?=
 =?utf-8?B?NFkyekpaeWY3YWc0elFTR3E5dVEvdDJJYlp4RWNhS1BRWXJNR0JRbktuS1Z2?=
 =?utf-8?B?L3o3aFdkV1pwbHd2amFMNG1td0NibFkyaXQ1SkVjSmxhcGZiM3JwZlJqZFJ0?=
 =?utf-8?B?U0l5OXgzMVc2bXhxMElJbWhpQyt0YXRoejNBT1R1Q3R5ZENvUFZaU0hzWHN4?=
 =?utf-8?B?TFBPZW5jN01yWTRFVTFxRnAzTzlTUjd3Zkx2TDV6K2l0TTJtZllRS3JGZ2c1?=
 =?utf-8?B?bTJXVm90dUhIcFZMcHJEMEYvcndxZ0paejc4cGRPSURrY0MxbGl4S1A2NUhM?=
 =?utf-8?B?TWdGL1ZtMUFaQVpPRWhiUnN2aVBQV1hCMVVaNEc4dERzMHRyb0gxYUdzWHNs?=
 =?utf-8?B?NWtuVlpKajZYd3hPR29iTDVUSCtKVk00M2NCQmRPb0VLWXp4UXI5K1Z0aVd4?=
 =?utf-8?B?UmpUYW1FRkJHc0JDWS9vUXQ3Tmlqb2pZbGlNVFowT1phZVN2STU2K3RrNXZ4?=
 =?utf-8?B?eWw5RmNFY2lPQndTWG5Gb0RybHhrVkpud28wN0xhdXNaTEZLUS9ZU296dndx?=
 =?utf-8?B?Szc4YzRZWE4rUzZKOTJldTVsakVzMFFmNGw3ZG1pdGpCeEhOVHhNUFVxeU5X?=
 =?utf-8?B?TGVWRm9YbFJPVTdqYWhQRGs2cWVmSnJiVVpYMyswcWJLOEhKd3RTMnZPODNQ?=
 =?utf-8?B?UkF5MGJvcG9ZdnlvL2RzQ2kvRGpmWlhFdUhLRVd6UEcwaUtXNGZicWFNS0hj?=
 =?utf-8?B?cUs0V0tkWDJIdytwbmQrRFJSREpLMkt3eXplU2lDeHRXZDVyQjI2TEh3RUlJ?=
 =?utf-8?Q?LQXQ4y3k4TWw8bBW+Rutq+loqTBFssRCrAypiPVzgRYwu?=
X-MS-Exchange-AntiSpam-MessageData-1: SdPUHZ96gLP/fA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a10be81-3ddf-4665-4f5b-08de8e39e042
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:53:56.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBF9XPhQzNy0FmwnVuWtlr63itR+Y3p64Elep8mCW+MwNWY6//F8ElbT8ElgjcRHmEGWG05wq8ORmrfz9cHryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-8410-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 08E25357C5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

this adds support for the PWM controller on Tegra264. The controller
is similar to previous generations, but the register fields are
widened, the depth is made configurable, and the enable bit moves
to a different spot.

This series adds only basic support with fixed depth -- configurable
depth will come later.

Patch 1 adds device tree bindings for Tegra264 PWM (compatible
  string).

Patches 2 to 6 contain the PWM driver changes.

Patch 7 adds device tree nodes for the PWM controllers on Tegra264.

Thanks,
Mikko

---
Changes in v3:
- Fixed device tree binding patch.
- Picked up trailers.
- Link to v2: https://lore.kernel.org/r/20260325-t264-pwm-v2-0-998d885984b3@nvidia.com

Changes in v2:
- Added device tree binding and Tegra264 device tree patches by Thierry.
- Link to v1: https://lore.kernel.org/r/20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com

---
Mikko Perttunen (4):
      pwm: tegra: Modify read/write accessors for multi-register channel
      pwm: tegra: Parametrize enable register offset
      pwm: tegra: Parametrize duty and scale field widths
      pwm: tegra: Add support for Tegra264

Thierry Reding (2):
      dt-bindings: pwm: Document Tegra264 controller
      arm64: tegra: Add PWM controllers on Tegra264

Yi-Wei Wang (1):
      pwm: tegra: Avoid hard-coded max clock frequency

 .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   1 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  72 +++++++++++
 drivers/pwm/pwm-tegra.c                            | 141 ++++++++++++++-------
 3 files changed, 171 insertions(+), 43 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260303-t264-pwm-57e10d039df1


