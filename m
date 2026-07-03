Return-Path: <linux-pwm+bounces-9534-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZK/wMELNR2obfgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9534-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:54:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E2703A21
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:54:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=opnnAGcU;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9534-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9534-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42C35300BDA1
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB43EB105;
	Fri,  3 Jul 2026 14:47:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819C2367D3;
	Fri,  3 Jul 2026 14:47:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090060; cv=fail; b=KzEmkG93spuRu4CSrlMWgTr71y6nmU0IyT/uD3UJI/99S86atf5f1uLT9qDYz2SqIiyfk9AKR0VNT80fU0g9d1cg+5Y/p5475x/p/iMac9ssyhuUHECu7iqrrXdoBrcqfMp7y8V584yZEXMrCSfNAoUGvbVhoUUnWNTOAlvnABk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090060; c=relaxed/simple;
	bh=zuYH+qSndY3kkKvUy3UJejQYA43UQSfIGUEvlkCx2qw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=I1HvTbhoz3CY+cv0l6sFp2NNc+qqoJeOIUaBklaRNDOQdTE4iQprGaJj/A6RGiZIn9ExsoEOyR9ymgKRztVtNkpLNqP9X6LYh98yurDNLfuCCkRyU2IvkgH8OkN1DUydY0OCrUktmbft6OQUORkHC7NqAdok7M9ZQPEvzl7P/8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=opnnAGcU; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPaKv5N/FG4PO/HTBrYE63kZtzG1gaKww2KxhXb1ooESOhpjIG2PpyCbaJ8YU3TIUGG/qi+Qs3XhqoO8avDFl+w57LcBsBot2QnM2wfSB68EECxMB23C1on4uV5w0xYX6ZXrdKdA7D/zVYUcTFxP/rv6rb1HajRafnHiBgl+39LF4OL4tZh2vyl01BpUj1ed/xf0OX4t7Mn3gWxiQ4GtaGAflNgpZYDk76mZhQfeyXX6FsC5pII9rvtN5gvTKiuvKXNzP1lorsWH07mXxeskE638mnNfc4rUit70f9cDYy3b42oyfHamMoMZ1dX9nKX9h4WC71inNFom+7m0c9bkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xgbCw+9uU+AMW5LOFPyGPMKjYG9cG5JZNTfuKnL5HA=;
 b=GmC41VtaFktIwXGSo4Qvi1mHM5c4DT2zHkZ0ORT9Qnh8sqwae6puGSGO1gDu7NhR6moxdTLnTJfN9jP9VPog3nebl9bn8RZegFbj7t5I6yEZvgd4b1mgwJcuX1lK0B4lLQDnpDc6CB8+19rWaJ0F6taQAHn9jWRtVG2TXAZkB1i+pkpJdKu+BsqprnIFd7Zkmg/+vI45fH//NWnE5IU7ftRw4GlaIVpuviXlQ2rZEA1heeE6cbi86EIfjGz74T3Yfs5JxrS+vmLW18CuUIWJRfrlYCsI/fIoI7V5CauvlWteR81ySd9XwqTariur84DUNA57kPk3kesiuNSO+ii8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xgbCw+9uU+AMW5LOFPyGPMKjYG9cG5JZNTfuKnL5HA=;
 b=opnnAGcUFShjXgJRnL76hngXGnXbKo+gUdfEUNmD9aqh8r8m/jY7WUndfK9dHJYkyF7ca69hO+zgeadxFUSLjDWxCzl7FvE1/MAurfe1fGTNe0jilAZJq3n3iHMxxb0Zxf/MbvfoEAaHmsrtKlY9VWw9nklCvuey7jKDX02Gm/oHO8JYKQSAnTIMNIMUYoM43xgXIyBrkA8Sf11s15ZHsXDYnIu6tljHESnmfK2LgP75O9WGo2vlHXbHpavvNRBh5sG8AJ0Dn/op70ocFQCD0S+5+XDMRDW2RlNymOvWWRdyTJ+UooWjJicAIJTInIBgyt2/GwPWkPSUd16xQLGEGQ==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 14:47:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 14:47:32 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 23:47:28 +0900
Message-Id: <DJP0O3WEHJ8S.32WIKQAFV09MG@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 18/20] rust: dma: drop `dma_read!` and `dma_write!`
 API
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-18-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-18-d0961471ae50@garyguo.net>
X-ClientProxiedBy: OS7PR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:604:24d::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f129534-4119-49be-e798-08ded9120334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|23010399003|366016|11063799006|4143699003|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KDNwtvuFhPgkCoHysYH5YxXmfMfNVn7GsEHa3HBESQyWSbjcJDtXlpnQ5uFLYLR5urHQuPFfydhyAkC9Sa72G2f552QzJn1I6jQfzjJ6wKPCv8b3BPn1wkBumNA2oByAhelOHXQPN3LwiqXUT/o5gyWTYEyBZvrMYfX+jndSQ+3vfml+KQ58VEWc0BQro02h4sP9kfrI4MI2IdxvETEjUu8wcrjKeA88BaEqE+wc3F8mYHgwW2BmcA9gcx3/4wzX2lMEDBIq+t4jYEd5caKMcbiRnsm/HdMPH/J1z0sAmQbpJAPK8O/l2byxR90qfy7GQ4tdsbuSlnJbn/Tw+bWd2YAAHxO35owpAWLxDYhMrtWPnT95OIkgoPcQFgiBcCRCeh7DT4GZO5o6wjre1ZNJygJJ3MEZF0fVqN7N+tfjKeP3hb4Ep72TyRbXUTF1AWNa4OxtjQZg+BjB16y+4Hf3g+UB3vOc09v7C1l1mfNtM1RulbZ3G/xtM7SPFAT+ikZYHv3hrcXCzc6f4UTtVpe4/uLCShC6EOQfN7kT1PPg0nLtnza5mMXn7b41Rzg55HmYHmevnuXeRrpRxafxpVsfaD3m7oTmDpcGjfZCuiWsf4+/rgskQQJ1Fq80QZtaQNiMxSrUgMzCa4c6JblGtI37gbt4jb8p3T66M4NeMWzH/WM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(23010399003)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW5YYVVMRHlOZ2NzWmhlUlEvWlE5ci9vZHhtTEJLcUxDTUVJNVdlU2xLRWd2?=
 =?utf-8?B?cHQ1WkxwVjZCZGRjK2lsNUZseGtsa0s4VTZWRkhKSytGeXl4ODAwc01kSEJx?=
 =?utf-8?B?SjlSQjhZVjJpNE5iSHNYc0Y1dEQ3a1BaMk9WMWVCRVhWNnhPaGc2TXVxOW42?=
 =?utf-8?B?V3czUzdkWExYQm1mU2FmbGhpYjlXdVVYOHo4WlY1eDBQcjdvOXNyRDRINHF5?=
 =?utf-8?B?QUdFcFlGay9PZHVpdjlZQUhsbnRjeVJoUS9EQzZCYXFVcXUzaDhHUjNBTlBY?=
 =?utf-8?B?TU52VjFoeE4wYTZOWGxkOHJIbFhENFFud0JSaTBpSXBpZlltaERjWWdvTE45?=
 =?utf-8?B?d2Q3VnIwZTQwcUdQTTl4cERiMkVwRm9pWjVEanVPNkIveFYwbnNQclRnaDJU?=
 =?utf-8?B?ekxOUWpScGMzSG5PWXJSZWQ5TUljVEtXd3NNbEthQnU2NlBIV1JySGtNWjlN?=
 =?utf-8?B?blRRdGtEbzBlV093UWxXcGE5ZnhXNUl2UmdiY2FIdGcrUmtBMWE4cXJKRXlD?=
 =?utf-8?B?dCtZOXA1K3Vlak1MdzFBR0hIMk82eDJjemtpRUpnR094a2FsM09QTncvRTBm?=
 =?utf-8?B?N2EwN0J2VzRzaVE4c0l2ZW1tNEhzcGFGZVJGa1pGTEFiMTBKNEdITEY0ZHN2?=
 =?utf-8?B?NDRKeURkd1ZremM0UHJvdG1ldGFSemtCRmFiM1VGYS9TbVhPbGxHYWdZSjhD?=
 =?utf-8?B?QkFXaTNtQzFGOTlEMENnZ2hXOUJjZWcvMkxaanR5WlAvcnRsckh5VjNZdG5C?=
 =?utf-8?B?R0o3UjVSb2RuenhWUHBud2F2eEdyVCthbXB0b05XQWQyczJybVVQYmJxTlll?=
 =?utf-8?B?dmVKTDZHZkNCRVlwZ2Y5cW4vYjhrN1FLYU1PMWlnVFdEbFpaYzR4MFdCcTVo?=
 =?utf-8?B?a1Q2ZldpVlRTS005cUFCYmhLUDFaNnZBMHJsaHJ4ZWM5bFFqV3NLSFRpaXlT?=
 =?utf-8?B?QUdPbkRwN0ZWeFE2VFI1SitnL3Z0NnlvbXpzMWI3VlRKNEtnN0xoK1FsS3hD?=
 =?utf-8?B?dHNMS0lWNkF2VEF1dDN4ZXVKNFpyeVhlNWRxSUJCcUFTeTB0MHY4b2Fsckoy?=
 =?utf-8?B?V3ZPL21aZGQ4YVQ0RnYrYjJEQW50R21RN2E1YVRrLzBtNEVkVGl2NVcvQkZr?=
 =?utf-8?B?TUtRL2kyZS9ManpVYnZQZTNOSENLb3dGaU5GRVVRWnpOMms1M3FOYzNCckFo?=
 =?utf-8?B?cTgwNjRMaDFGUGh4VSs3Nnp0RG51QW1MTU5Ma0hIOGdKNlFBdEFLYStqQ25Q?=
 =?utf-8?B?dkM2RUF6QUpRVHNpZ0FHR1VpQjdwZmwraFRTbXdGNTZzU0ZDOG4wb2dqYXVo?=
 =?utf-8?B?TGI3bWx5ejh6MkJVZUYvYk5uOEJiV2wxY1Q2WURHNDYrMTIvNDlMQW50Y0xu?=
 =?utf-8?B?TFJWWm0zTlh5d2JLTkdsSGE4SzVOaFQ4OFhlOWEvY3gxYWFXSXFMSE00dDgw?=
 =?utf-8?B?dDNQTmtmNlg1R1NHWEdBVHdpZHJpRWgzR0ttS1hGSldGTUxrVTZNNHp0a2lK?=
 =?utf-8?B?TlBBNC9CV2krcERxQlg5QWZKZmVBMXdtMXpUNVlUckZtNU9uR3VTVEdzNGd6?=
 =?utf-8?B?RXRjYk5HQisxQUU1QVZLVkl0eEw1Z0lNYi9aTXp1bUQ4RVhtTElqU0ZhVDRo?=
 =?utf-8?B?K3lpb3M5VGxPMkFGZ0JpMHhmMEdlS2JpWHVySTNJQ1BYem91OXFVNWdrRXUz?=
 =?utf-8?B?b3o2aWNHNzhCbzlhYXJnaG5ZWEF0blFKN00rbFRqQjJ6U012T1J2THIwTkdF?=
 =?utf-8?B?NUJZYldxbjlVQUhEeGs3NWREalQvWmljemIraXBEKzRKSUxiY0FjZnMvdUlT?=
 =?utf-8?B?aW5QZVEvdkV1dVVObllkS1VNMGdSUWtBSkc5MTlVSHNWTFVEMlJRN0dZSVJ5?=
 =?utf-8?B?TG5XYVU2clNCM3NsazJTZXVrTEF4UkhObmg5QWUySTdENTVCb0xPT2xhRjZj?=
 =?utf-8?B?d09hR3U1ZitjM1BIbTM5WFNTc0tOM3lTZFE5MFlIOWg2WlBYRjhyYXEvVXg1?=
 =?utf-8?B?RHVWM3BFZXJRZW5ZMmsyTERQV3VhNkwvQm9pU2dBcHpRTHBsN3hwbG1WM3Yv?=
 =?utf-8?B?c05uOGFaK1pLMUJmZCtseS90TWRsQndEUFEveDU2eFUyZmhQZHRKWlZIYkt3?=
 =?utf-8?B?Q1BzUldwWnZUMmVQaFJybklzdkZiM0h5c01GSStxa1ZkaGxIV0dFWSs5L25I?=
 =?utf-8?B?VHRkK1RFSUpCZEF3WXJSanVpNEM2UzdUaU0rS2ZOZk1RT3ZCcHVGb0NCeHR1?=
 =?utf-8?B?dTlBZFpPVU5JL3NjQmt3c05MY04xSFRGYnFQN2RDTlZNdUk2QjZzTHYzK3R1?=
 =?utf-8?B?Nm9DUTVveXhLc0E1ZjdraXFjcGFlVmoxNnViK3l1d2c3SW1TYWJLbkFQQlE0?=
 =?utf-8?Q?6ZVbIr7VjqtiWr6m4VzlexTq+07JszoF47DE+8umyop3x?=
X-MS-Exchange-AntiSpam-MessageData-1: t3Ilf7MwEmRzZg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f129534-4119-49be-e798-08ded9120334
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:47:32.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F70kOD1nS5hCVJ3hATLOQPItlSqMCKAUP6KwpiXfFwbebAKXXGgzfrpumSGkq2ys0ddnokztcnxPkIMJOFkhEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9534-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,garyguo.net:email,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E8E2703A21

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> The primitive read/write use case is covered by the `io_read!` and
> `io_write!` macro. The non-primitive use case was finicky; they should
> either be achieved using `CoherentBox` or `as_ref()/as_mut()` to assert t=
he
> lack of concurrent access, or should be using memcpy-like APIs to express
> the non-atomic and tearable nature.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

The code looks good but the build breaks on this commit:

    error[E0425]: cannot find type `CoherentBox` in this scope
      --> ../samples/rust/rust_dma.rs:77:25
        |
    77 |             let mut ca: CoherentBox<[MyStruct]> =3D
        |                         ^^^^^^^^^^^

With that fixed,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

