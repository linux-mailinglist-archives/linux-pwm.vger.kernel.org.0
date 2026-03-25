Return-Path: <linux-pwm+bounces-8361-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBMtLiq6w2nUtgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8361-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:34:18 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 158693230F9
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AAB7319BF0B
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 10:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208D93B636B;
	Wed, 25 Mar 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sL9LVynO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC54B3AF650;
	Wed, 25 Mar 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433886; cv=fail; b=PGuH0OBbKDN6tJKPFMAchccV0LghGD671++XMegQSoshJDgPoBuYFu/RtCWcGYevH84llg6RLHC/EgoQuEA0fyYAKdKbr6JcYam6dQS7zeH2DtDzJVhtIhkH4VUpSAWxdUphVhOcVmDKVvztFROQfaL7QrmAtqCWOFO0NqahfKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433886; c=relaxed/simple;
	bh=Evj6yJSB0LLQL+CIC5V2U8+LZLkz/oljN2lXio4LwqQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X0Y0NbgKA459UiVWRhcmbeoKuyGtn0sVirOpgzb6RdScu1axrcqb8TDIJDPGEz4MdXd9O3TFXDECEa7ymD4IOb5Xe5XY9qId1wLPNLsK4dnBbBqZ00xi2onTt9kBgXdLNTWQK/mK+pHX8bJR3FLaiHKLvCZzhE7XljncrIpS2wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sL9LVynO; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hU2LnP58s2xKxjPYcLa8DDyb5QEkcFxrLah+O+/Fd7L0xace92a7ff97tCefe9PeL0pz/o6HIXdX4QjuF/kRh11SZP+iX12Vsbzxs0XdqbxH7VaFWMfIanlc+iwlhBSsn1IAA5XFEpJs76QfmdEs9nK17nEhOpdQfz5IuPTP0VGxCAMO1AHnAPwdsdopwy8NPpBrQQkI6AuReiXtsTp8Au0csq2qfZBgh3I59BXGEVI1Zy/yVYFBXMl4ObIIttggDi1FzS6O/ykdQTNsuYwFV7DHmHdBB0TpPe3lt7C9UB8rf2uab0+6KhBbZEVGKLehq5doxbzPdtn6zyCMRtIGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD56M22Y17aXtRpKBTowRAmFt2qj3NH7Zvb4xJmEOR0=;
 b=Vs/pNb8JnX6eOlw8/D44WmaPBfEA4RDrQ9D4M2optES5Ul/YHa13oKmsLtM5E7DdPHc2nJ3SeGzCCMaB2wXi7vhmXPMUQq+EKFVSh9487jE0ePlu5KHvi5skUPVVYst+54Z/+J+4SET1PduWqmsl/tlG4xkyyFCXeBJDFWRPsjXr6rAfKJG/j6+vhtOJx8CEoj3seDoUNMp7AxU5CwU12F3gOj6F14P16zTmZCpUrdwngL2doLBbMdhSbLokXxQIfLfmoRtKnFZQY83Rw+73PNN/1wejbGnbUdM6/qz3HHxT+d41sZSfMU7KLHjHL/BX+c0/S/PbwDW+xJpue4JWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD56M22Y17aXtRpKBTowRAmFt2qj3NH7Zvb4xJmEOR0=;
 b=sL9LVynOLDkb4PnNfnTUoKK6n3yTW5/3eFWHsxWqSb/dxQuVofplUTauHQm33DGPqMbScRQmEEhMaEeLQ+vcyVk1Z+8T15NpbrDy0/1LQNenDD152GgzIE/EOi9YVfUdLu3MLByEUowfOXlExwTuUR1XPWefV/8c2mvokfaaWnYaUAHUxAVXGSAUTE6+/yJdtQoc2JQGkR4q47PCH4MeZmXbLBaHCWazTsGVc8CFFa9D02fvDieYi+/cTEZ+1G1y6q5INvAu8Tcuzq0rKt/GaRex6C2dphYywRx8wx9K5EKF17jbv5XRzapzkMhWL8oVh4w/Op0fKKs3jczavAvhyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:17:56 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:17:56 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 25 Mar 2026 19:17:02 +0900
Subject: [PATCH v2 4/7] pwm: tegra: Parametrize enable register offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-t264-pwm-v2-4-998d885984b3@nvidia.com>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
In-Reply-To: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TPYP295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 28eab333-179d-4983-ffdc-08de8a57c838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	h71yOdEeH+tj2jemc1/RtAkX85mBe6QVhSkp90KrTWBVfC0/pVl43nIzd+1Xo0ZP4rTpL6V9PuGH7Ttxws8vbmPcjQfrLzL2ZmhWAClHPR3G1omg0lXRIkjMKESa5I96KqqjkG5mOr6CzaHcBHTnRPit2DT53JlsiEMDTmJzVdCoryWyxjEU/Kznv2u0RCfi+yWPF27+EB1QJ5uFLDgxr/vhQmiSzvmdOLmhI/VIK2vVBgKmuhG1l9GIFXhk4faVmN7hKx5CQ4kKXr7fFEq1PUZuTog4P+79zpzQoBuX2KJDR6VpfThp6ekIqwHtVpmP5O5YGmopkC69Ld/2QelxxUj436IEimBneYgBf7pd98R8xX6sSB93vzswXxnsD5g2FPFFj0qujHdOR6BsYPrdJoZtlRW/9+MVCFkveb+yuTqks6jXgZ5Mz3PX/PCmhrP/gXPe0Q7rj30H0LO1FC/YmHV+kTB1Zqh25XbNnW0kuuKiU8kI9R1jVVMU2dPWwTy2s0g9qnwf4PXAYPm+F/mI0Z9SjD8PG5eUBR3feTUHMEQwq8bcogUMaKI62oeddRROWxhwYoO6Kocd06auZykVDwzYoqzsstTGUv4jwZTAm0nzIPfHHEf4XdkER56speBh9CTIEHBwTT40zUgayExjOMj+IDmkRknNykX2gZ1COT5Y93TG/Npes4SGlpPFUjMxTWOWtJ+bXnGSYjdnPVCCWqmBmYL3nRcZdP5rAca58AU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkZpMHI0Vk1leWtqa1RUTXcrSlgwVVNNK3N4U0VPejVxaXpYRjBiY2Y5WU5T?=
 =?utf-8?B?VzBkMTZyM0VpZkt6c0VFZE5FN2dOeDNoeXJQZEhMWjkwZUJtZFg0RndUWVRP?=
 =?utf-8?B?RzVnVlJ2cU5JUU12N2FDVnhWUVVmR0IwQytVbVNLczAycmh6d0RwOXZXUUhx?=
 =?utf-8?B?NUpNdittUGdERTJUV21PUm5GYkdHQk1qaDFnTVFwOHVLaWt0bzJzNjN4azBu?=
 =?utf-8?B?K0dKSlhjMmV3NWNNSThMV2R1OFRGeUprQk5lV05IMFJ6dFFzYzl4NHE0SmNw?=
 =?utf-8?B?Wi9tTkF5RU9mYUcyb0gzOHdMakZNd1F0bmpVV3ZBL1lxUWVIeEdKdDUrTHdH?=
 =?utf-8?B?eEdVWThUMVNhbTdpczByTXBnWFMzQnU2Q3dtbFgrV1F3MHZaQzRZdEo4bDZy?=
 =?utf-8?B?N1hHQlBhNmdwc2VITWdnelZkUzlvTDlTY25GcU5FMWh2V1dVbmxFZ0c2SEdX?=
 =?utf-8?B?bVZOUGp6ZEEyaU9oempVRHNzN0psaW9qWE53VUhFUHlWR1V1K0NLcVpoYlc4?=
 =?utf-8?B?UmdpbDk2cHdEaExUZ1NYdlJiU1UxWG5GeWdMVGRPTHJLaS9JM3RzZy9nRkgy?=
 =?utf-8?B?cVBHQk1XYUw4WEtkVGlhZG5WVkkrTllSSDFpVktwVHFiR2FpZjR4ckhWUWJN?=
 =?utf-8?B?b0hzSGMrWEJJMmFSVjdqS1NqTWpZYjZJTFB4VHVyUTMrR0wrczIvQnBCSkpu?=
 =?utf-8?B?VUVOdnhKWEhFT2Z5TWtpeE1NUlNnKzJ2NjdzSUdCTUZsb1VrakRGMktwSDc0?=
 =?utf-8?B?THhaSTFReEdRUS9nek9iUzUrT09sVVorOEJRZkdvcGtxbDEyUUY3OHp6TGRH?=
 =?utf-8?B?YzB3Y1hjUjVqY1BiZmkxTkdBM1RRaGt2UlJwZ3dzK0YrTVlLeTI2SlpVb2U3?=
 =?utf-8?B?S2hxMXFrSWxtTUNrbms5S3ZWdDJMRUNpNU0weFhiRE1TYjNGQ21XbXM0blR2?=
 =?utf-8?B?SnhVZlA4NEVuQkxnczRFQzQ1NGNEL2hyL2pmSjlGaVBvcEJoU1J4bjlrSG5F?=
 =?utf-8?B?VTNUVGF1OE8zL1FQUnFTay9OU0hNblJPbVZoWWV6QmNlUXNISW5zdklKcXBS?=
 =?utf-8?B?cURsZm5mV0hhSDVCSWVHK2JCY015VTBDaU5ZcUdDbmtOZEJhZFppZ3J3WlE3?=
 =?utf-8?B?S2tlMGFLTTlnVmhHS0FUWUQ3UkNsQ29PTlI2QmthSjE4WVdFYlI0dmNXemxV?=
 =?utf-8?B?YkpRM3RPUGh3eW1GeTB3NEZQRGJwVm43Y2d1QW9sRE1Eek1oUVBkY0J4bmwx?=
 =?utf-8?B?d2M3alc1MEk2Tm1MYS9BRjlrYlBySTZROWF5amxhYXV2TTJLaW5BbXFmMklM?=
 =?utf-8?B?V2IrQUNlZzBmZXhvbnEzMDdpbEdMQTVpWjVZdlpEQThSTGpMSER4cHdZSlQw?=
 =?utf-8?B?M21nbDA0WStXbytEVk5RT3huNVZaRzg3NjZ3TFl5NG1HVGo5RlBMajZ6bTd5?=
 =?utf-8?B?VUI3UmlWWmNSeWl5U05wS3hJSENrbS8rYmhHbkVkYWZQLzhaMitKdWpEV014?=
 =?utf-8?B?UUxTTTJ3RVpybStFNmVpcmZBOGc2TDFoVmwxeHVVVkhKVk9sNlhTYy84Nnpt?=
 =?utf-8?B?bjMwQys0VTlnZHluNGNieVhiRXlpM0xMRHU4aEJJK1ZzTFJDVmppVHk3QnBZ?=
 =?utf-8?B?MngzMVF1b2QvTXp2eVpGdmJyVzFsdFE0NkNEZTNzMGxEU2t4MVd5OGplYmlD?=
 =?utf-8?B?Y2N1R3VOa1kyMGhDcGxGOVY4OE9KWFFoTzBIUXRxWERjSXlVaVAwenAwQWpH?=
 =?utf-8?B?VU1hL1RiQUEyN3VLSzFFdUorV3VKeVFSbE9WTVVLaTZWQ3BEREFXNGJndHFM?=
 =?utf-8?B?MUQ5NjF0RlhxZEZaQW9VaGRBbE1Td0dvQm9Pa3I1ZTU0TmYremZ4OWltWFNG?=
 =?utf-8?B?eWlqaTI0NW9yM0J6VlhGazd2bnhFU0NVWXNLK3VSL29NWmFHM3M0WEhlT3pM?=
 =?utf-8?B?amc3dkJrZk5xMUhDNXUrY09CYU9jdmMvdnNVUzlQVzVDNVIxcEd5NEk4SkZx?=
 =?utf-8?B?ZjA5eGpXdWtmSEIxWmxnbUtGQXkxdTNqQkxMMFY1NVNwZ1BnQ29MSlY0NW1w?=
 =?utf-8?B?UVBYK1pselBsU2V2bnpTNlhBcFlic2F4VXhZMFplRmQ0NVlybHJNRUdFcUNB?=
 =?utf-8?B?V0JXNm1MQnZ5YkpaYjY5aW5mVHFVcXNBeDlTeXdySVJxN1ljbjUycEdwbStT?=
 =?utf-8?B?V05yR0NseWp2UG1CMDRDWEVoV29xMFVidTkvMk5KcGtPTkZTRkh3SjlSZnR0?=
 =?utf-8?B?aHBxRHp5UUsvYVFVU3AwbjIwWmZ3cExpWWFRdVRkSFpJZ21Mc1FEbDhIS0c0?=
 =?utf-8?B?T1RuVWtYSFdzdktmUFlqdi8zM2ZyK1QxeGJTRWdGZnBqVnkyVWljWWtFRzcz?=
 =?utf-8?Q?gODxx6Fqvk3dBSIXDL+iKb0dI90jbOJNMu54atwZS/BoI?=
X-MS-Exchange-AntiSpam-MessageData-1: 6CPEuarZvqw2nNO6IetxyfPg9OLU4jjh0bM=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28eab333-179d-4983-ffdc-08de8a57c838
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:17:56.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laMUZ7geOlB+ricISC/KHX7QNvFb0zhWFpsJz9p/d7rNRfkqw6Jf8dhYNl8LBgD5ZTbSYryMMGM5G+KmyI5ABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8361-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 158693230F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, the PWM enablement bit is not located at the base address
of the PWM controller. Hence, introduce an enablement offset field in
the tegra_pwm_soc structure to describe the offset of the register.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index cf54f75d92a5..22d709986e8c 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -61,6 +61,7 @@
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
+	unsigned int enable_reg;
 };
 
 struct tegra_pwm_chip {
@@ -197,8 +198,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		err = pm_runtime_resume_and_get(pwmchip_parent(chip));
 		if (err)
 			return err;
-	} else
+	} else if (pc->soc->enable_reg == PWM_CSR_0) {
 		val |= PWM_ENABLE;
+	}
 
 	pwm_writel(pwm, PWM_CSR_0, val);
 
@@ -213,6 +215,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -220,20 +223,22 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = pwm_readl(pwm, PWM_CSR_0);
+
+	val = pwm_readl(pwm, pc->soc->enable_reg);
 	val |= PWM_ENABLE;
-	pwm_writel(pwm, PWM_CSR_0, val);
+	pwm_writel(pwm, pc->soc->enable_reg, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = pwm_readl(pwm, PWM_CSR_0);
+	val = pwm_readl(pwm, pc->soc->enable_reg);
 	val &= ~PWM_ENABLE;
-	pwm_writel(pwm, PWM_CSR_0, val);
+	pwm_writel(pwm, pc->soc->enable_reg, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }
@@ -398,10 +403,12 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
+	.enable_reg = PWM_CSR_0,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
+	.enable_reg = PWM_CSR_0,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {

-- 
2.53.0


