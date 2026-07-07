Return-Path: <linux-pwm+bounces-9617-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7rhwJd3uTGoFsQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9617-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 14:19:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1337F71B4B0
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 14:19:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="HKw/xQZ7";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9617-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9617-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E12B30444DD
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2026 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73DD3FE362;
	Tue,  7 Jul 2026 12:17:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4523955E3;
	Tue,  7 Jul 2026 12:17:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426651; cv=fail; b=Etg7t269mVOpvDU/kO1YQccBd9FbO5rpOpUbyN0KyTYqpiHjFRobpCXJgGP70zKRZt8249nGGfKY6qClKsIjZrIKh3ZlmaiB6k9nWF43jRVxPpGDFQJ344rAUPQJCxt4VONsc3BRXvqf0gjwAwLFJkhmV0DyK6CVqnIYvSVL1eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426651; c=relaxed/simple;
	bh=ECMnqzjjCVSPSyw/vsvnRp58+eqCdKfXipR5b3K5raY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=RE+kM+8ABZX8xNAqU8IlbV3F7eGvZ7C69rObVAzR7C72X5m0da7MBhld0l3jLcQwp1EeNM6f87IO142OdXSpzWupCLeFWGB2GEjtP/s1YnzkFvO6XMEpyMUyX+jLDeKpBgWzgExURlU3KIfZhWFqFtq5mUd/Ae20QTBOfxVQ5NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HKw/xQZ7; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yulDVWMtEHIjj1z9dK3QpiHsy+WcjUTxizE3XkHmCVrH+yGjum3HPLUUbFDvtBBmkCGVot0sVSCIc5ULXTa07Gxm0/6Q+UUMtJQr64RZgoZkaFu8fSA1V8DQom5/wOVHAiE6fO1we3ZbXwVbD8yKYqcD+y7If+yxyJ0jssUcw8x1v7cLdOjHFQkLVxfrw1D5c7FSO5cDGYTYsQ+oHAK5ZQA48eLKdlCUHCbLOQc53a5Xptou9P7mHPBOTvCLGvi8aUEQixK4IgtWJBceTjmP1z+JZ6p+YftN+R/dGHs0SwQbLq5if7GjNaJdP+yVAlyJUFWBCisMpZhtdGZWpWuGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBEm80D4hUWVjzgAJpeF+ZOwGVdY+Ew0vWkLmUGqk5c=;
 b=LbB7Cym+K7zbV2qQwUmr8n+uzgA+WVtLtWSgJvJem+7yfawBXdNJ2ruPpKLJLZZDcSxX0iZqWhvgKKuOr/kGJ0IpsmuFtwlD2vBll1AjSlW3e2hYahfps7SuXAneXmm3fUY7QAmbE+Yj7oEx/A6RmuG6RTSbMgVXppFs1uFMW3nzxn0PzAqUPjZdSXvy1CSBJHbBUikH3KcR2/hyHFSXIeeCfRAolaWUUwh2bpzNDd2di9IWwy03HENKC/s0dCe9Rp0W9ywIL4cLacFhMDxoA0xzJR3IIZC1WiiOOlUxBEeZmoRVYqBttchPX2yv7PZL5K97UD8KVLahWO/H+37V/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBEm80D4hUWVjzgAJpeF+ZOwGVdY+Ew0vWkLmUGqk5c=;
 b=HKw/xQZ71EJJ5RTSe0zajIeH5hKol26girRbEzoHoabIuqh8xgHg/sHLOcL5G7nf3xnqMvEqmNzSgCC5LRszx6Po2eYgASt4qhFWF+cIPOVF+Gne+I9hP3xaPxaE1xTli6LrufeFsmmWYN/FfQH0TNDWvE57yhy+F4Bn51TMF+bpnZK0gphPd0dc2kUZ3P5m4qW2WEE/Npeamkh3+D7gBmmh0wORQJY7TblJlKgsfr1U3BpZaPmQio0hkqGG71EutkoViv/QBCRvosy67noVlVy898bx7xHCKNQsTgxXFmIA6TU+kUzG6Fi5QhAgd6CVXoXA85iiIMHlUrV0+1BDwQ==
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 12:17:23 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 12:17:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 21:17:18 +0900
Message-Id: <DJSBZBFDAAMM.38N1H7RP6FJV1@nvidia.com>
Subject: Re: [PATCH v6 19/20] rust: io: add copying methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
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
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-19-72cd5d055d54@garyguo.net>
In-Reply-To: <20260706-io_projection-v6-19-72cd5d055d54@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0189.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::14) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2119cc-4608-42c3-1b8c-08dedc21b2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	5EqVAGTgrSHm0wjhoT31XD4AitAcN/HX67LdoHlinoaRIZTuNXRPPWXSqqANXixBRo4CXiz5wSb0VDVD2HBT7NUtRTQNILA7lZALPs4rvYfJw6ECovFkZYu/ANibGcPiCb7ih5Hi011vOj/qu6AN0aSfuCNwnyj9e0c4rt+AbTFVdp5JIS8bIr9UrUt0KB+GNVsWJ0JudeMtyrgBrqiKB8BUiF7sKTJukCMqdPIOVCS78LaSKf59SGqWkqOGK73Elzs/nSVPxxu1oBNn5WPI+Xkzi46Ej8JtEosW9S1hVqSbfWg+LKhoXihMkCGEYXPzwerTq6hPGjGae5ZmGI7awWnLTkCE/6Xa4+qPuYwNXmdL7P3Yuep6SQT2WcSkY7bCxHs+9hP0+eFGqWkkOBkQQGBiGM+H7xj2mgR9gmDUpGH1fAzWQ/nTc7+EB7+VlzU4mzJtAKTlNg0AoXkrr0u7b/7aoxsV0/s3KBtz6OBf64dAoakO/qFSnKkvc2TX6fl2/U3k1vMqoPr2st/DC65cLvcFGJSMn/J4er4yhFnhX3nadasr9mWtDuUwddKbYAtSNfz5fVxwsRUSfRI5en4pgjDuWawA7zTyxMs3sGxHBjEhMvPRIdmJSq5kAjR+dN+o5EBGoP2OZSJ1eNp4lsn1QI2ZnJMBNoxir5e1apLdWQg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QitIK2txaWxBUGtKcjJyU002MVdaUUJwRnlrcEJkQjZaYTMrbFdtL1pIK0Vz?=
 =?utf-8?B?RUdCb0JQdkpnTUFSWkxMMzl1SE5uQ2NyS2wxT0RoMFJHZkdLOStuV0FHOVE0?=
 =?utf-8?B?bXVsdXpVbFVFcnFLYytrM3JJVVp5MVBRaVhFMWp5WmhXYjM3cWw5cWVjaXBW?=
 =?utf-8?B?VnJuVWw2cVNMWTFUeEJWb0s3VitoaHhxVFNWbTUvS21pcFZKYnRpeU5EOTdK?=
 =?utf-8?B?QUhtTHdGT3Q2YldodWlDWnhzTVRucXlra3EyLzRVMFYydjNBUTRHN3Q5ZGgy?=
 =?utf-8?B?MXR4T3A1Z0loYXg0NEJITXB3QmxyRDZWSUdVYm04YXNqWlZZVDlOcjd3dzUz?=
 =?utf-8?B?TUVjWWowQjErS245Nkd4S2xkckJPSHpvK3MxUEpKWUdGOVNZWjVKMlVvRitv?=
 =?utf-8?B?NnpqMEhRZHp3M2ptNi9JOGNXTURzeFE3ZU9aOWhmMjRZejVIVXNxL0FYRjJK?=
 =?utf-8?B?azh3Z2RwQm5qMittb2hKM3MxYjY5SzJKaitXbGMzNGhKUDhEZG14U2ZTaFNJ?=
 =?utf-8?B?QVNKV2RNV09aWmREVVFIeTJqcTRySEVBb2cyazcxWkVueTNmM1BtemU5Z2RF?=
 =?utf-8?B?c0U2ZTlEVGVISDg0ZmRobXgxQkRsWWpQdzh1aFVISCtiYmY2VWgyRUdpODVr?=
 =?utf-8?B?YWhGbnltZmQ5VWNjeGQ4QU9vanlRaXhhRXhRdElqWC9jTldkeVQyRDluWDFD?=
 =?utf-8?B?VUZkNER3VWlYeWRyaFpqZjdUU2NGTTlMczhYaE1PbmFWWmJkRFZGcnRKREtH?=
 =?utf-8?B?b2ErOFpTMVU3YmxaeCtZL25NVklWUi9YaHRYVzNCei9qZFdmclYrTEtRU0oy?=
 =?utf-8?B?OFJuL1IxY05uUndEU01SV3lqS3oyeEFFQnZ1STMveEJrd1BodVVzbFZPejcr?=
 =?utf-8?B?VWdWa1BadysvRFY1YmxVZXVRVXVaLzJCZGZmS3lIQ1p5QmdYTU01RStNaTZ3?=
 =?utf-8?B?cjFHdkk2WXlmQWFKZ1YyaUFlV0NBUWEwZnNheUxaNTJXUWhXZzRRK3prUmFJ?=
 =?utf-8?B?bTZBcjB4UjVzaUVreDMzUjZYZklPU0JQUWVEdnRjZHNMUysxbnJDRVpJN2ly?=
 =?utf-8?B?eXVucE9tZmtrUlluRkU1NzBvRldIVHNjNVJOUFl1bnFCbmJGdnlsdFNZWnZP?=
 =?utf-8?B?aWhTeGJiY2I0Qkc2V1FkcmxoaUtaTFRyQkNkMTlJYTNQY2g0akJMTXhNcGRS?=
 =?utf-8?B?TmFoT29DOC9ldHExbkNuK05LT2YwZVBhRk5TcHFzQ2NweWc4SWRqazV5bWtD?=
 =?utf-8?B?Y0U4MlE0aXFCMnhJaUJ2cFNGMmViQVN6enJ1Y21ieTN4eGlsMERXTVBFc3dm?=
 =?utf-8?B?cWcwYjUvaU11MkdDUFpPaDByNWNuejFCOXlyaUl6Uk0vakxrRXU0TnlDejRQ?=
 =?utf-8?B?NXZ1UG1uUStsTTJYdnpiM1pRd040UkNHZTFTTTREOXM3OVRjcUYzZ01jclVU?=
 =?utf-8?B?Um5lbVp3S3JQbjJpM0pyUzUyNUNNOGZkcDNMamhPdWxFZklKQ0FVOVdsQ3pT?=
 =?utf-8?B?cXNOZG9udWk0SEw0bTZLZW0rMTM2RW9tQWYzUEE3K0lQZGtVLzhqQmJiMjU3?=
 =?utf-8?B?RmVlUU9odTd5c3VXdTIwRkxiYk1OSDlMRVhYN2hvN0IrUnlmb045Ylp4c0dQ?=
 =?utf-8?B?bDdqWVFqN3M1QU9Sb1lMWWFJQUx4RUhWNzI3SzBhajdSOGZVODFPcWs3UDNu?=
 =?utf-8?B?RnVzNHBNRFNDWVJaKzVsam0rZERhN0c3SWo5NnNSLy9zSmdZYUFCNlRQNGRQ?=
 =?utf-8?B?M2pKYjJZTEFhYWlKZmRQZWh1SlhUWEpzcWxJSXd5TFQ5VnNnYnBsNU84K2lK?=
 =?utf-8?B?U0pwcGNNdzZmOGc3a2pBRXM5bGpzVjlrVGZsaDY2ckkvYXphYVY0MDBTKzVB?=
 =?utf-8?B?aHJ3dG1BMFlDNTY2MDMyWGZPdXFlN2NPWXJoTHhmRmtSNUhmdDhVeVlxVXNz?=
 =?utf-8?B?NWJLRjFydXVnbnBiUEdlZ3IxYTNLb0xuaFlibFdOeThQaW4rekpBS3A0ekhk?=
 =?utf-8?B?Y1o3aGhiMXRYZ1Z2c205UGY0K1VDcit2NjRBd1RFZ0RUOGIvZFhibWhxQ2FK?=
 =?utf-8?B?NG10TDVKc1lwVXJCWlZ6cE5QMHFDMzdkTldsZ1kzc1VaSjFPQW4yR2M4dWlE?=
 =?utf-8?B?bmd0b3BBS2xxK1NFSndqaWVNU0JFVVBtWHVDcTBndXhvOXBxZllUWGJjUjlK?=
 =?utf-8?B?czA2b2JWaUtxdnNvb1ZxdFRyRWpLYkw5ekZYWVU4OWd5QWthNHIvd2QvY0dC?=
 =?utf-8?B?U0pYVDhTa0p3MDNyaS9XdEROempyenFqd3h0dGNLSWpvWHNoY3JiT0FjR1Vl?=
 =?utf-8?B?KzNvWWliUUlCRVFWZWIxR01xSUk3UlZoLzJOSFNyQlg5L0Z2K3hxNGJhb3FI?=
 =?utf-8?Q?/W2z7ghfDvBc2EhsKkd4/utH0lGc/IfpKqMRcexo9P9sX?=
X-MS-Exchange-AntiSpam-MessageData-1: OM8MPYFnMYa9DQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2119cc-4608-42c3-1b8c-08dedc21b2f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:17:23.0408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TabuitDVfESlXXGbkNdoWtt5YrKweETaUhWUjv6qzpQ9MxqeVMHVnR5vsTxotW90emoHHm9JVhm5PHTOH7lbdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9617-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,garyguo.net:email,vger.kernel.org:from_smtp,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1337F71B4B0

On Mon Jul 6, 2026 at 9:44 PM JST, Gary Guo wrote:
> One feature that was lost from the old `dma_read!` and `dma_write!` when
> moving to `io_read!` and `io_write!` was the ability to read/write a larg=
e
> structs. However, the semantics was unclear to begin with, as there was n=
o
> guarantee about their atomicity even for structs that were small enough t=
o
> fit in u32. Re-introduce the capability in the form of copying methods.
>
>     dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
>     dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)
>
> Model these semantics after memcpy so user has clear expectation of lack =
of
> atomicity. As an additional benefit of this change, this now works for MM=
IO
> as well by mapping them to `memcpy_{from,to}io`.
>
> For slices which is DST so the `copy_read` and `copy_write` API above can=
't
> work, add `copy_from_slice` and `copy_to_slice` to copy from/to normal
> memory.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Thanks for addressing all the feedback so promptly!

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

