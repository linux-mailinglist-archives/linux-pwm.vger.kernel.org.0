Return-Path: <linux-pwm+bounces-8999-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCexAOVKDGrjdQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8999-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:35:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A757E57DB7A
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B37E53124048
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B09480DE6;
	Tue, 19 May 2026 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xc5vHpur"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CA26A0D5;
	Tue, 19 May 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188838; cv=fail; b=YvE77XqBpLF9Zzu4o02gCbIDLP1lQG6WEIO/KZebuG6ZjI2KMAxd8qef6+AVLg5gpXn8uumLu8UJBXQaPyw1n3XBiKa8nnXvfhFOBOMKkfd7Iyym22XuxGDz6JGR75nHAAhKVP2By1T5XrGIb/ByGtMtrVYRzsa8Y9Cg2hPzxyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188838; c=relaxed/simple;
	bh=6IHwFr15EyOUVeBMeuc38i0sgEgj23M2RKXaamKcC+U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ae11DcmHjbdLspiY6AIarW0i94eAny5GZ8ycb1dcqy04neNvs+DnslDUwnpdl3BI1x4f8JkIti5klEr7QFNIUJW9dqLzf4MvfYqXLJxbmGFBjYCHwDbw4A1u4CGcxh48uHMx6uvPYnrE6Z+1xPpr0qfjmtMbCIWkewkvrTCVCV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xc5vHpur; arc=fail smtp.client-ip=52.101.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNuKwOLYEqE/XgSbXTqpSka/fk0qjpRRw6/mWX+Fkhk+x0+ZXtESCco8sytbxdR5UQZlmpVxOPZ/o/IwF9WcVdyaOg25opmKV1E2B+7a2pPMF/IoojRtivOovk6Rr6TUKRh4nYhJJ3j5SOCeOmsgIIkK4aLs8A0nRNemkDq6zqavuTH7QV0771TsyOmgOAp53XO4FH3C1xjGc/CqzlZRm3u4MYyloJBkidXs5IM1NnliipjHBMgJLVz0WjK9OrDdwBtJDuvIBT1L4n4Fgvk72RPYimn94xhiYBq3bxSeHGc1iC4z+nFgEumGN0qBQijtTPKVjtenFimlEWnd3BqseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pb+aLTAg8dWuBoxqMGDtopRs7U86s8IvFuClWGKIkpM=;
 b=UGzKP/HpYc1U9PNChzDfQx/afPGWGt7aU6a9kuT5eJ17u4vcEnytLbaAeIqrLJuiYKgTe9FHicM+NUBaG3cPQzaoq6teEBNBGNDbc50OcDriv2+kFPKh8EXW08IZaH8j1q02xOflDBBiDapwmlTb5CptE2PfhkDekZ0zlYmES4caAYX7LOVgZjYTs7Y3CP/eDonvvlCjcbu+yaNSksSdjwoDaTmMTHkVSYpqFNgbQcEJfli17qOlvmsEYAI8SbmCJw+vHkid4QfObdjOWfN0DwZnF0dbSUbCaWPMTb33G2NeSzxdXW9LhC9xcZ+YTJHde0SLNAkwAk6LVlj6z64XIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pb+aLTAg8dWuBoxqMGDtopRs7U86s8IvFuClWGKIkpM=;
 b=Xc5vHpurI/INECYpDXsHWpTPIQSaKNFG7vbbcadGCDtm9EN/vcgBLnZmSrzV+17OoPeqE6e3ID9MlzD2Oby48zOjHO2Bd4hj9jsJrj2fDYpnKhPXxAeRkTPWA851sZ+JgRhl/imHFOivp3N/s2NwJe7AtGWu5YlV8GavEiPcuVpjg3PBmxHZgWNR8FfXtDlxZENyljpFQIG21CnRV+kKFEr6AvG31+nmR3YGd7lQeWN2czuNx+mKDiIOlzZ1XT62DBgjDSm0LfynHnZmfZL/dJ562zv08EdFuyiCrGW29cmwIiIant3FOmH9cnqdurOe6lMWO7fubswCqGB8J2AYxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 11:07:13 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 11:07:13 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 20:07:06 +0900
Message-Id: <DIMLSVG1IO07.28UMFL4GTCQG4@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-17-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-17-dakr@kernel.org>
X-ClientProxiedBy: TY6P286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::7) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: e951cd35-d309-424d-b7ab-08deb596c5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|11063799006|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	JX9SKSgkXkn3dHIO1wIOLjzM4WCgmUf+0sY1IJVJ6qduMYH+a2LIxYEf4fm0/nyoXOXB3VdM5JcV/U5ht+54KdGqgID2B/arE6Rdpwi4hUkQEcQnceL/oOff4gan/D26RLoz8I5hJGLFmaOi59BYZHigXEly2H3yoPACos+nDhR90UMFhVXcMn9vLI/GWwQPogb3SC+EN9RdgqArvQkbLnCyVdXk+yp2Ufno6xrbCjZyGnL1BlkVn03sWDl+iYqBDHSOKm4NlDBZy7lYSZw6//4qh4G2FX0XMAxTmrYUAWUpuuB97Y3hk+mgkhnwa+gci5QUt+EvKgmcmn3diT5y8pL4qPBTGVS/4JhEPnmEgN/UBZttYZ01h1It4LxwZ1mBicBV/HH+duokhXZ6C8F8WWUtOdhCY1d4vYTdLTVI+9pr2/fZ2gvSJ03XeAwqX/h/YWPndzeJFfBEVPdObSBEJM/DTo7shQw5qORbAAMu7tXJPdZqfvJ+ZogQN78J64Gk/jY7VQ592/KiWz17eZVv7sbA+xHFSNReRyd67Vdj/tHTvoDHXk/ifkwxYwduRhd0bkgWtdpu9YsE3DLuXpR7Ph5nyPHC7iVBYVJOHO4PCeBVB896h05xKTd+TBDDYxWfYj/YJwuvcjSZIR3zASeokA0Hoh2xA/r3ThriQKmvP0L7opXM3r3ufbM/Du6Yjn7g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(11063799006)(56012099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUpLblM3b3h5Y0FNT2R1OEhRcmtLVFp3WE02WE52bHplS0xpK1VyRTRCL2la?=
 =?utf-8?B?dHhCZWc1Z3Q1S3JlQkxPbGNBbW1BZS9idWJuemVWMmFFMG02M0VLQWlCNjVx?=
 =?utf-8?B?LzZVU2ZiOU8zMHpmZ3QyUnJhcGwzRHpPN1pMR2o2SkYyYjBmY01wL1JkYm9C?=
 =?utf-8?B?dVBqU2Q1WktNVVRqcDdDOE13NzhMSXd3ajV5ZTlId3M2NkN4WWUyL2xhREdW?=
 =?utf-8?B?bjRxeVdsMHpia3NpTzUyK1hOeWliSXExVUwzUUx2R05pWE9OL0ErMTdJWGdR?=
 =?utf-8?B?OEozU3ppanlRSnVoYU04Q2FLUm8zNjZ0NU9uSGNsMysvVTFmYjd3dkVJMzF3?=
 =?utf-8?B?SERFRzBJNXZUQlZyQVYzVG02YVBhNVlqYjdMRDZpVzk5M2hXR0hNOHpvbGg4?=
 =?utf-8?B?ZysvSkdvRk45MWNvOG9VRmsyN211MUMwMXkrVzM0S1RLZEIxZlh3THhpRHZB?=
 =?utf-8?B?M2hCZjlrUURodC9Vc3VrNmJDRVRiaERkMzNIS09OejlqVzFDUHg0MGhNc2pm?=
 =?utf-8?B?b2xVaGkzYXEvK0pEYU82akNqY2plZFZSa3hlNTcvazBLcmpkdVloY2R0MGpK?=
 =?utf-8?B?TWFoeGFoMm4zeDdPd1hLdlhmc3ZJcGgzTTU4SzlBQ2F6bDNEaHNVZGVacmFj?=
 =?utf-8?B?d1dSUEpIVmMyQW1ZcG5RSkVTaWdVemN5SHE3eHdqRHdnSHBpL0lxK1d4cUw1?=
 =?utf-8?B?SkIvV0hDR1RrUGd2eGpYMFRMTkJPbGM4UkJTK1RHOUZlbFUycW56TWFCSitH?=
 =?utf-8?B?ZXZWN3ZJSEQ0U1BEazVqWXZGUytLQjBwM2dUU01QL0kxM1M5UFNRZ1VVZGR6?=
 =?utf-8?B?N3MwZHBTMXZqeldLdlZuVUlNYXczTm04enR4MzJzNlRTMlV6enhWY2c1d0Jv?=
 =?utf-8?B?Zks0NjNVVGJjVzFJWXZpS2U4QndCS3BndlRYdmk4ZGZ0cXl2N1Q3OEVsSHlO?=
 =?utf-8?B?R1hnaTZBbEh2RkZiWi92Y3ZlTWs2OWJzSDhSTjRrNTB5ZTBFd082Y05HUTN1?=
 =?utf-8?B?Zkp6aGxqZlhJeU9sa0VFd0RqZ0hZREVPci9qaFJZbXFrVW9sWDhZRmlQekNT?=
 =?utf-8?B?Q282WENycHdFSzc0bjNEMmRGblVGVWhTcktjc08vdVJsZlNEMGJCMzgzVDVT?=
 =?utf-8?B?SURrdElFNStmbnlxSElNaDNoNWdxcHlmRmlHQ0RPaXQxMUEvQzlVem9TSHVX?=
 =?utf-8?B?ZHI2dHFZMWxZcGM5M0dKY0Uzck1mV1d3KzJyUU85dHdBMlpqaC9kNW8rd2ZK?=
 =?utf-8?B?a1VWby96VmdNcnh4dWlIOXhlUjBMSGVsZ2xQMS9aNFdsdk1ISjVoM1E5RGcw?=
 =?utf-8?B?MjcwUFVPSzc5ZkxjeDQ5SkdEOVRIN284d1ZheFZHc2tsZk5wQjI5M3hsdllY?=
 =?utf-8?B?dkJXY1ppblcvT1ptRmNKTmx4Zm1NbFJ4eWM2OXdKRU1UWjdZM3ZPTzBEVS83?=
 =?utf-8?B?V2pWdDcxK2hidlRaUmtzWGRhcWFrL2V6bHNoNTBNMzdVTkw3aXdMWnF0ZC9t?=
 =?utf-8?B?NHRNc1FBd2gyVG5FYjlYV2tmeGkrNmZwUFN5T0gzTzlqNGdjbEZ6K0k5Rk03?=
 =?utf-8?B?MXEvb2dnUzFCcDlheFBQSTlaUnF3RVVlUGJXMkIzK3Y2NC9KRXZBaDhQSmF0?=
 =?utf-8?B?N3pYS3MrL1hYeTJYUzl5QnBUWS9Id2Q4L1dHbUhydTZXL2lXN2FGdEllMHJu?=
 =?utf-8?B?c2xqU2IwTkRGSm9oZHBlTmVoMU8xYTZST25nZFhDOVFpQWIwRW5YZFEvS1JT?=
 =?utf-8?B?aG8wNFVVU2RGYlhHTGEvQUNKRkh0cFlHcG5QRHNNNXplQkZHdHB4bnJ4YXcz?=
 =?utf-8?B?ZmQrL2VXa1ZDT2Q1OE5TOVFETUo2QTQ1RFluL2R3SzVacFFVZTgzcW9xamxp?=
 =?utf-8?B?NmJwQlc2WTlLem9hL2JpelM0VXRWRkpFSGRheC8yZUVkMlRQcU1UNWhDeGpi?=
 =?utf-8?B?Y2trSlNPUEZHa1crTmlYTS9ndnR4LzE5WDZuNTN3NGtUZFZ6M1o0cXNqa2Nr?=
 =?utf-8?B?bWxiTGV3czBqUUt6a0dCeEpnNWJnNXBoSThnbXZSdXBiMiszZGYwb0V1c3VX?=
 =?utf-8?B?K3ZZRjM5TGNkUDhTdTV0eE4vSzNLcVFWaTVLVFZrOEZWMUpkY0N4aFNYN0dX?=
 =?utf-8?B?YTFBTnF2UXFleXBBRnFsMGRCKzlodXpRcXpVR0dITUpxSnRZVDgrTTcwd1I5?=
 =?utf-8?B?UXVZOFVPbVV2TjZpVWNSRERPODlva2hidVVsLzRLYmJ5M3U3aWxtcnlObVVF?=
 =?utf-8?B?TVdQTVFGQXNNT09ESm51cGRBbHlXWHByVTRIZmVIRVM2YWs0ditnUU84Sjlr?=
 =?utf-8?B?dGFTY2RqeFFUVmVwd1NHRFR2VGg4bTBYSjZMRENnK1ErTUJZUnBsUWM4TDZR?=
 =?utf-8?Q?FDdzuig/OFRPleiuuiEOjjNMRvJUGoHr0/A6tRDxprkpS?=
X-MS-Exchange-AntiSpam-MessageData-1: MfJbaInp8V31jQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e951cd35-d309-424d-b7ab-08deb596c5cc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:07:13.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7Kln3/L9kzQKAxgzHML5RyXS+ubEcN9a9w3wsGZDEz5ofrVlC7frGC1yNhBRZ62G4UO/czLk0OfsFrB6WIdPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8999-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A757E57DB7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
<snip>
> +/// This is intended to be an "unsafe-to-refer-to" type.
> +///
> +/// Must only be used by the `ForLt!` macro.
> +///
> +/// `T` is the magic `dyn for<'a> WithLt<'a, TypeThatUse<'a>>` generated=
 by macro.
> +///
> +/// `WF` is a type that the macro can use to assert some specific type i=
s well-formed.
> +///
> +/// `N` is to provide the macro a place to emit arbitrary items, in case=
 it needs to prove
> +/// additional properties.
> +#[doc(hidden)]
> +pub struct UnsafeForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData<(W=
F, T)>);

Although the documentation makes it clear this should never be
referenced directly, doing so is still possible, which creates a
loophole for breaking covariance using only safe code.

For instance (untested, and based on my limited understanding of the
patch):

  type Bad =3D UnsafeForLtImpl<
      dyn for<'a> WithLt<'a, Of =3D Cell<&'a u8>>,
      (),
      0,
  >;

The blanket `ForLt` implementation applies, and now we can store a
shorter-lived reference into the `Cell` and potentially observe it after
its lifetime.

This could be worked around by defining the type implementing `ForLt`
locally, at the cost of ergonomics since the `ForLt` type would be
declared separately:

  // Defines `DataLt` and implements `ForLt` on it after emitting
  // covariance proof.
  define_for_lt!(DataLt =3D for<'a> Data<'a>);

  ...

  something: Devres<auxiliary::Registration<DataLt>>

I'm not claiming this is better; but imho the tradeoff is worth
considering.

