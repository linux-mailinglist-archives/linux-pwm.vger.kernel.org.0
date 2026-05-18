Return-Path: <linux-pwm+bounces-8960-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM7POfMnC2pAEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8960-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:53:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5038856F48B
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33BB53059FC5
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C426E165;
	Mon, 18 May 2026 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUQXrRAj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAE261B8D;
	Mon, 18 May 2026 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115612; cv=fail; b=XbjDD73ulu3CBTuIzJh2+r6outkjV3f88txnaszZDFJKkHuQ1GQ0WTV6aIRSrPzS9nn+C0Q2pU1OO87LrN2mLqWL4DZVylyIi94Oo5mQRbSH2C0W4HXkFvq29p4Pxmx13ubrUQ4fGw4gC9mjlR9B1/HbTyatnXjytBMkK9sJmEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115612; c=relaxed/simple;
	bh=3NFJ6mv9HJbRUTrhvJ9W7g92mxTDxv80sDNob7/EJ60=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=HGQcpjzblxk9A1LadowwpYCMdpvvrIKZhkOoeKejDnyWP0rdgUWd6f/BufALekFwq3ofjWl0cE79sHTt1vZ3Vx45XyqNIMiGhEcttTpESjol7zV6jAJiPM7uvesUqyNCceqnLx1PMtnvFLaI5toqaehb57t+wFhTuOD9owDM410=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUQXrRAj; arc=fail smtp.client-ip=40.93.196.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EA+V/v58SeXma8pT919mJGvep+WmwJxhYZ5y1CUaCzbVin6XsQVgxB88x2/Wszmb+qRh17Y4kVMEcbNIYod5M5Z1Hz32rj9uckX5HF+jCviYLF2PI7ZnjK8VBRW1bLHbIuB9jp5Li+5IG5N4qAidTRchH9Ie5uuiwSEmXT1Pr+yj+IVu9S2YF5m9YQAoLtaplL1QQG8bw1On+evvtpjpGM4p7PmBv0F5kgqMvFZPohwqdF8kre0OLD6jvWVC3CASimc3RK0FHlmsT3G48mL98OlIVMV7biTk9CA49z9DebZMJ50ih4DIYgswe7FtRM2j6kJGSHHtHK4Q7q6H/h6QiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NFJ6mv9HJbRUTrhvJ9W7g92mxTDxv80sDNob7/EJ60=;
 b=FWI6IBHVglTZKYdxJXK+w4hw6a2wyOj49r0DBAEbZWvZK4/dMLKHWqRzVhcNBKP+fuIDqH6Zf6Qv78X7x1ycphDZ/ZS0N2F7oZYp8/M9/Xl2eRg8N/BZxMOxpmAKvv3uwX6FaDxw70s8kH3Sa8TZD/Aga/r29DekqKIsZh1rQHwgetiYz2aiPJvX2TaBpwIUdZL3Vd8h1wweQd3SRdCkt+c8wdj5VP4uU53LGJkVEg05dBw/EennhjMJrjC5zfxIpkbScT+0z8ALphke/Q4gXp/9PAI0ARsxxlPDydVuwJBEMyaPVMn3B4ei4O2Z7EoKFgi0UQ5nmV2LEhSDEm4J0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NFJ6mv9HJbRUTrhvJ9W7g92mxTDxv80sDNob7/EJ60=;
 b=dUQXrRAjjmZCxXiXbZvjEX4YGk2js9DNfEghfx2EE2H+63j5kdvPp1LfncfUF5WKPSxmnnxv3KWqKciE6o1ss6iFI3cCDFwWz3YZkwh1ImuBwtdrd2LiRdRb0TZAbky8c1X0yZFr7yW6heoz+2K5jBRn0JBlALmUDGemMUAVCrEaAr50i2YqGoXb9baYmjSEMUWNjyEi58KhEOE9FPD63qFQhIWPBA2b0seqGUygGxIBHzDb5xzlUOmkmazaN4KlrGLCMD/ah7nLaYvLvy/PfoBAhprFxebtBQbQymvks48pFVp3tJRdluESPJ9iaL/cnLczBgHqJDydsY8gOEj9Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 14:46:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:46:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:46:41 +0900
Message-Id: <DILVUG9INW3G.EPB2109IOBM4@nvidia.com>
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
Subject: Re: [PATCH v3 06/27] rust: platform: implement Sync for
 Device<Bound>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-7-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-7-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: de2297ed-ce65-4474-f219-08deb4ec481f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	3iqZmSTXYivRMbhV0HlHs4Om2t8rOdZa+eGU5rYgg7lvd0Mccr3vVXLPYU4B3jPbUfl7CymzQkbdsIsPLr16AQmOt5FPwkI3I0qnW71HkE51fJK7Prdtdz+1aRqyuuF813yh4I/uER8YHeK1KNfG5typr8ooqEpOrfrB7VJpqO7484fEj2SOzK0NbKnJfoJuB76EyTI8YAxb3OPCgGK/RnzpaQz248VgPF9bFdVpmjEWE7Vaq62lwo2C1OaDDm1SEEV0KxT8T2YDos8afQZZTx+FRpTohNcxb3i6mzCv1VxOlq7ZweZi1YX8vQXKeuhIexg9EEuVhsGds5poK0bZ78Di4PDDEjNAUvjnqCCbktVhmrJuo+Xp0dpND2/HiXuJhueCbLjpeaNEXVpfd7AxNyWMk1aZqWwPxikgYg6vgswcM0ES3B434qV7gJVNpn6ZVNYIWd2X8DubtUUCFmidocW1218en+pr3H3pJmXDbSzhoBQ0YMje/yEUNpGjQJ+63kCEygYx2gb0QtiopZrVW6lSNRqttVmuGfQmHNi3zf72+znQPLxRiSNJpb8YQaNWKbZu0AXTSE6Mhl2rLnSoes35whpNXkU11yr7DUwfrFeuDKvWQvB6cHKLJBqNDN1pMkuVw2QDwA0mQPKAJUo82Vx8X1nE7IdT+55O2Jzo8YJyYv0IwnP7Tgk4byGxGy6P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVlhVkZUY0hrTGRKcFdIOU5pQjNURmw2ZlJQTlMrbmZFZkhjd2lXYzNEZjZ0?=
 =?utf-8?B?U29aNElOVTljNlNIa3REYXdUdDNTMVJPaVJwNEp5dU9YTjI2ZXVVTVNRY255?=
 =?utf-8?B?ZUdWTytLQnVqUVZXdG5LN1lhK2dUU05OVTQybzVFbjAxaHlHaEd2alNCek5Y?=
 =?utf-8?B?aG5lSmNCeXQ1MHZMWkNwUUhYNjZ4dUwwNVYxeGFCaSsxQlZLakZ3UDhla2dI?=
 =?utf-8?B?RVhsRUYxNG1FRUZPUVZNZ1hsMG5FN243cnJxZzB5VU93TTRMZVBLa1FzM1ZK?=
 =?utf-8?B?L3hyMlhBaTg0MG5Xb1pSVUNMZXZDb3c3amh5K2FTYUEwM25KOUM3VFNiVzF6?=
 =?utf-8?B?U082RHp1Y3Q3RDJmWXZlT3A5dllvYnlTTDhtc1F4TklHTW5SaXVaQldhS0Ra?=
 =?utf-8?B?K2dUNTFXZ3ZZT2Jha0tKNWh4WVYrb0VsdlNwS1NGVWwrckFKTVcrUTZFMHJZ?=
 =?utf-8?B?QkhNWXVLQXZOUzVyTkdoOWxDQlpKckR6SnJUSnNnQlN0aXpST1lMRlNGN2N6?=
 =?utf-8?B?djg4Z21tWE4yWUNhanhqRW9rckRNNWNSZ3phSm9hU2NjLzg2aE1lZUUzd1dJ?=
 =?utf-8?B?akcvaXN3bUxycGZSVmRpT3N5TVZrY1hPamRWMkR5dkd5UjNvZGQ4azlRSXM2?=
 =?utf-8?B?Z25hb1dqUGs0T3FtWEtUVkY3NGxmMytGVkVOaVlQMzdwcGxhZDRDNE4wMk9h?=
 =?utf-8?B?Ymd3YjZDQUk3aHV4a09WNnFFN1JkYmFKNUVERldNcVJNNm4wQ3htcUVmZ2h1?=
 =?utf-8?B?THhDS0NUcGtsTGZyVVRjQ05reVE2bU45MlBORmRzV0FvNnpsV2kzcUxpSzJX?=
 =?utf-8?B?N0lIQVZHNU5abVQzTXJ3TnNOZGdVYjFyZ05xVEo0ampFQWh4eUhId1I4d00r?=
 =?utf-8?B?TE1OYzg4bHdWYXBHOFRGZEtxSmNmNmhhcW1WT3ZJYUVtUW5BaWtGM1FJT0Fq?=
 =?utf-8?B?WGFVcEZBNWZubU9OU2N4ZVEwNUk3WmtEYWV6WW92SEIreDhWQWh3bkQ0Wkcz?=
 =?utf-8?B?U1ZFQUNKNjNkK3lsb2RHSFhSSDV2UlV1OXpIS05NOHJvZXlnR1RBL3o4V1ZE?=
 =?utf-8?B?T0c4SzNHQVBBRUVUQUFQcVMyN0lwS0QyNkJCQlVMTUViWW9lMmFabW9ZbnNn?=
 =?utf-8?B?Sk5Dck9vcHRKQWlJa0V6RUhpMUxjSjRQd1VCajNoazl3VFRKTjFaNVZ1YUxV?=
 =?utf-8?B?ZVBpR1Q1cTFFTjM0MjgzK2pFZ056Tnc2MVNqWGFtdmNCTXo1WUVWa0tXZHdo?=
 =?utf-8?B?bmNET2ZjMENodkNhNHNLQU5FWEE4OG1KdDhSYmk4elY0bGViZTZZTEVwVkxJ?=
 =?utf-8?B?TVphRUM3b0ttcEoyRjNkWFRVQTh0cUFiaDdRVE5hajgvcCs1ZDF2NDRuclVh?=
 =?utf-8?B?NW1xM1RGYjRXU01VcHR6RmlFbVYwQW1QWTQ1M1BVZlgwMEFRaU04K0NnL2d0?=
 =?utf-8?B?Z2h4YjdWVDRNY2UzMWJsRzNJWmgzTzNIR0dERzZiSk9MN3JkZDdicTBtNTU4?=
 =?utf-8?B?ZW5hSW93RWhGTFNFZ3NoaXkvSkRsVGhFN2gxL0p5blA3NW9zQU9vaGNQTTBj?=
 =?utf-8?B?UU5nV05maFA1UXFpUVgyV214anQ1aUVUc21QSzh2TmNCejVWemd1eTFwNTBT?=
 =?utf-8?B?V09ib2lnWUYva0QyYzZIVFprT2VIQU1XTTRVSUdwMUc2RXBSZ20vSmtBWWlv?=
 =?utf-8?B?TFV6VFVMYnlud0lkeU0wdVhGaFJ0ZWxvYjExRFJ0a1BlSGpHVXNZQ2ZhZHQw?=
 =?utf-8?B?Nm1PT0ltM3Vzam4rSmo4ZUYxZFIyNWJTL1lNZ09zc2Z2ZTNNSGkvS3ZtTzFq?=
 =?utf-8?B?NXpSUitIRkUzTjFFOHJJMWRZSVUwc3NtS3dMZTFpekNvb2F4UXArKytDVURv?=
 =?utf-8?B?V1RQSW80Sld5WE5aQkF3UWZ3eERzaGhyVDNpbHljQlk1a2NYOHpYbHZCdG9p?=
 =?utf-8?B?WUNSUmxaUGdIRU9TKzl5MkJiY2pvbVdCemhZaVg3T3B3SVFWUHRremFMMnN3?=
 =?utf-8?B?VnJxc0xaVG9PR0h3dGpkVDd5a0FWcGdPZjNDUzkzajNNTXY2Q210WXRrRExS?=
 =?utf-8?B?d1dhaXU2Y3dZVkNqN1diREZGTW1STFp1cmVXQ1VIZmtrbTVjUWVVajFtTC8x?=
 =?utf-8?B?S0x4WjFOWjVoTWlvSUxpTFZVVTRuc1U5Q2l0V1dDNG1kUXVqdUdEaXNMU1Vk?=
 =?utf-8?B?UVFXQ2hjbVU1d3JZM0RYa05Jdlc5WTJpV1krYjJKYmc5bW1OL1pwQlFPN3ly?=
 =?utf-8?B?ZWVQVjV6enhMVXAxN1RvUnAwZjBVMnBpVFVteU83Mm9VN1pNaFdmQVhFTFNo?=
 =?utf-8?B?Y2lsWUMrUDBQUGttUGJvMG5jL2V4NVVXRnJBZ1VLUWdpUStmcmFvY0FvVlVV?=
 =?utf-8?Q?YXe/LZaPa/i81Jy4e/4Yob6syxuPVKGZGPyGm1+CzVtnV?=
X-MS-Exchange-AntiSpam-MessageData-1: 6Z3MRLKleV+eRw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2297ed-ce65-4474-f219-08deb4ec481f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:46:45.0390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbCoyyUjq/tg40X1Omni9Ory+fHbp6Qbwx38IryawMDbe9oO+8k9Vm7roj/MwWHjE109tZbXtgHa4xylmils+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8960-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 5038856F48B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>
> Device<Bound> uses the same underlying struct platform_device as
> Device<Normal>; Bound is a zero-sized type-state marker that does not
> affect thread safety.
>
> This is needed for drivers to store &'bound platform::Device<Bound> in
> their private data while remaining Send.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

