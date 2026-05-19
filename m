Return-Path: <linux-pwm+bounces-8985-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIgXOx39C2qrTAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8985-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 08:03:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FEA577B0C
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 08:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 633643034309
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 06:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99296377EAF;
	Tue, 19 May 2026 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nwbnVKPA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828C377EC1;
	Tue, 19 May 2026 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170577; cv=fail; b=k5AKiPWZfJU4DMRZVtGzNSQvsHl30HpDX/Lz4y07peOa+tpvsRFiVVeFxzyGS5ahC56FUwWleOPhOaahGkTo6qrvdP7depsxuVFby+Aw7rlrIQ/fPBQ/tVzJhnM5HSojyznpkWMbP4PnSdq09EtpHB9m5n5L/ptrNqZvMuqUHvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170577; c=relaxed/simple;
	bh=rX7s/f1QeE7jLuUoDDuGWVVd6j2C3seLFpY4KkXPjF8=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=co2HE82BAVoJAvG51EEKKTBndNhLFK+/WBOZYOi/BuDdoKV+kdijW7vF9D188dZ5AW8QoaEmWiAKDvOFVhuF7decmm8F23jfdjwW3AQfbtEYQAE8pvThQVRbYciUMbZw0us4HCce7iErsDGHRE1CoR3I5mWtf+7yV6LtBTNO4/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nwbnVKPA; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGNurKtGTeOPiqhSI6dvpYiEAlff/oaHEt4YNuzYZFDIv2Eit0+JoSh7VQ5aljlv0IbCSGbFZia4KXpbj7xj06PBH/Y7wDyX3GVLCpugzjXNz2LwRH87zuJScb8/WO8cRWTO/Mi6CzbqIhzP0ZQDRJtVSuttHVkwZbMBwsSM4xUjwJnJOAnmclvaAhBQgGH+D7N6mdkBbVV0CpGKWn189EmmCOfGvnkjsvWwPoEc4rOp+VNkcSWXQsMgMhnMqzBx1Nmuj4roTJomRCrPzoKdJXWoXCGILXLYJKSFdvuMMv+SpBq6+KqrNHkAj6kUmvJOsJIMZwAJMkPZEihNs17S9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNdaC7G16O/x/qWJzZhSHkZU8K79nDCKxprnsOyDUbw=;
 b=LtVaTI8Dscn/WqKHEeSWuNPy2UiZqSJESkkklBsbrGbmmAUBuTRKo/4ZDWb8CcD3U7ZMKxnJyDvTiEwS2sct8wTMdOB9qwvMQS//YAaMwnuGVzrwcjgc6quQO52J8icbApT5DwD3Pe1IDLAeypvBEsub2I5yFfZoVXZrg737WnzXIGlZiJ7LfSXpy7pe4itdc86lXmw+dbDDCfMl31+LIymZVUPYS0CqobtpfHSCqDMvd6AWa1dZTGrg5RvQdYwecUFVSHO+fJWZJ+8CjiPZXP9q4MeBrQy5EZ3rh5inKJ/LS5H8r4SOa+N94cawRG9EROo8OpngbELm5OubBmgRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNdaC7G16O/x/qWJzZhSHkZU8K79nDCKxprnsOyDUbw=;
 b=nwbnVKPAwYOLsD23lmLlKrEThPBPCzfTIvc84sTW5kzPtVjX16BQBDsYUxOGDVy2E2wc6yP5wnv0I23skeuzXjuPpPJMnAkUauYysz0dqsQRPx+34Zvysbc/Djg5IiB7NBgBLPC1noEBOyBeHBda4eZIa6/dEafOTcRkSjr3wfX/ZDTzzTVvwU7o7s8oCgTeMe1WWqTaRxYuk4tnhoNCnzaFgisR5L+EFy57v8k9uQ3Qn+CYUjxe22J0gDlP1Z+bz6Hr7ccjqa7dEVRfcvg0YjzZ45uz8nOW6BGRQFFy9wczx/8pagehVsN3ePstxlMkiG/ANcmsM+M28tv8+vprAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 06:02:48 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:02:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 15:02:43 +0900
Message-Id: <DIMFBTLBNISD.W92F9DWEFSX@nvidia.com>
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-17-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-17-dakr@kernel.org>
X-ClientProxiedBy: TYCPR01CA0193.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 7322857b-7c52-404b-f9d5-08deb56c407e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|921020|22082099003|56012099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0lWfuFz7AKNW9Mg5vN+5gyaoLX47JwVu3LjaA74wHapXto0njrz8zzIaOENlY7+ywP3vH7C8B04VvwGOXGV9Zmpj76J3Eyl4PToE2StQkDi+XsiQxCvf8OVlVsBaN7rnX5hcrEopIoEJQLOkSv0N3YnEiTzxM9XJzsIiUyy6C+awWSUkmmPQHh/KIjsHSfAVju3MlEzALLYF5tAkpCRZ5FLH7MREzNHUk+axlKedEpm3m55yHVR9R06YtqFJdNOn08aoSc9b5x5alPZuwYtKtKlKJZ6nQFIjnpLsEXlRsY1t0et7kCI8KCJCjeeDZ9Nxd1kYkCoEmsVJiO4VkjjUcD7gyFVU3IXolq2iZCTzyfJLI/qQEX997Y8UPHmPgtG7FHTZ76KrkjbeWKGPasdy5rNpgy5aMLIgPYIz0u5/oNg53feyQaffuQKE7yhQE2ZoXNNPkwWb7IISTsT/HAILk4H0UXEmoZSl+mZQXpBhmvucTF+zsduUMe9HhnO5EhVS03jaDxfwNY2VnJ7zGjXnBxMqE2GTZBga+aGpFGSKsUrngCfMYUJ8xgqNsinIAxcvyUZbEnxKXOytgo6aNamqFELw1W68jkdD1/k+Bsq7xC8w1cSymOrzT730bJPEg3eOkXHphQiouKMPpzsIZjZeX6p1vl3WycY9yjq21yeuYbSMluB575hyaJSjkGSYSOLu8ZiAKZ4DVYSDHhFd32NEZ3/Q6D0+CWBGqPhfE6VoCN5sJal3vv82M+UJeBcm1zhF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(921020)(22082099003)(56012099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzdVVkV1ak5DNzE4L2dIbGs5UllmekNuWHdqUmNlY3N2Z1dVanF6UXl3c0FO?=
 =?utf-8?B?bnQ2ZU1yeHhkbm5Xcm1mOWhVejlKdG1Gd0RxQlpDWW8wZkp1T0tieEhvY2du?=
 =?utf-8?B?OXFFRU8zbkF2K2xsa0I3VWdCRkg1eCtNUUJVVXhBck9qZytGTnNZWEd2cjY2?=
 =?utf-8?B?YW1YbFVoRkZsNExwclFXRjAyUjA1QWdjaTYraHhkMlptYXowbGhuSlNLSity?=
 =?utf-8?B?WkhVWkRsYkx5UDY0SXlGZkhYTStkMnNsTkc1T3RVdjkza1hCYjF2QW1mWExH?=
 =?utf-8?B?YmZ2bHh3U2tYczY5SnA3RGJwQWgrbTZJeUt3UFBPMUpYWDlWSEl3anloS2c2?=
 =?utf-8?B?by9OZGxWdmpONitzODhFVWw5Y0RtckNUeTQvdDZ3aWw3WElzOCtGY0Z6TW0y?=
 =?utf-8?B?NURyYTdYTTZWOGFrYW51YW1vTlJidUFJK3A2eWZ6anEyME5BMTczU0RYSHpz?=
 =?utf-8?B?WFFTMzlsR3h0UzNmbUh4ZE9QeTFrLzhRNXZNMnVNNTJuY3I2N05sWkMySTBk?=
 =?utf-8?B?UElybFdGN0UvclI2RktvVGM4dGM2WVY4a3FmK2xvb1AvNFZjbkZLejIwd0F2?=
 =?utf-8?B?RWZlUHp0MnRSZndER2V5aXdNNmdwUDJjUTVHTldqaTJaelRPYUFRcWVEM1NT?=
 =?utf-8?B?MG55UjVHSlRRU2Vlbm80SncrOWFMMW1Ic1ZLSEMzWEFORVBHbHZjckUyNmNW?=
 =?utf-8?B?TTd3YTRmaWdpeDREZjVyWFBGSGpiRmJJd045a2l0N0xvSTdXNHNqMU12Vy81?=
 =?utf-8?B?WHMwQnlVbWRPZVhySk1LV1RCVXNIa2RMMkNIajZ1NzBUQ3dFT0FBTzd1eUl2?=
 =?utf-8?B?YUd0L1BSa202Q1dubHFoRWJSVktweFhlMnFSSmlSaHFMOHV3dU5tenlNa0E5?=
 =?utf-8?B?RFBhYmRMRitiY3FFNmZlTHZlOFVhUVc3ZE1vd1Y2U2EyVFZ0QklEZXVBd1ZO?=
 =?utf-8?B?UHdnYkM1dFlMK3BkRUJsQmdMQ0R0M1AzZlB2dStBUlhXeVJaQlU3UFFoelFk?=
 =?utf-8?B?T3VRYkYvYjZHNFh0a0lrSm50SE9XZDFnSTluOXQzd3NSc1hQdlhvUG1CV2Zj?=
 =?utf-8?B?RWRzN2VHR2JpaWp4aW1yVnZ2bWQwRVhUa0dmNVh1cWNRRDBEdU5lYnVLYWZn?=
 =?utf-8?B?ck03UEVZSFc4eUVtalhwQ0d6cWdFVUpnTzJucmlydU5QN1JRZjdlamZMdzMw?=
 =?utf-8?B?c1NFQUNxbG9zMEFtb0h1V2Q3QmJVb1FJT21MdDZyQWhONWpSdlFuTnNGN3NC?=
 =?utf-8?B?Q2NWNHlMOTY1WXRwcnVDa0hEWXM1a2xhMnhjbDZ3YkxMa05ML3Ywajk3Rm9s?=
 =?utf-8?B?enNna3NJWVpDNTlNRmdxU01tNGsydGxSTHZvKzdJU1FjYWVpTXArOG5nZlVm?=
 =?utf-8?B?MVprajVwQUtZSVRFUHhVUjBacWtJbHlpV05EdllyendvYjlKRjBLdmYvOExk?=
 =?utf-8?B?Nnpsd0RlQ0lHTUJ3OGFBekQ4YndBRFQ2THh1d3BMbjZOZEFHRjRTQzF2TUlv?=
 =?utf-8?B?ZzUyYjIvV1JVTUJaVHBNQnVrSVo1RTBRVDF6dEJuQXlnNjA3Nk5lUWtnd3BD?=
 =?utf-8?B?bHJKTURKTDJKQkZ1VWg2a2cxSWltSEJZOVF1V0kxK2lyWDRjazFTNExoTmRn?=
 =?utf-8?B?MXZCNkVYVXltaC8yS3U4bkNOVWt2V0ZyMUtFSWRkVkc0VlIyZHRUa0dpbkE0?=
 =?utf-8?B?R1hXMkxhRjJPd2M0NVorNytMWnczZmNvRlVSbVFUdVoyblhudkd0ZWFPWUp6?=
 =?utf-8?B?ZHZJMVQ4VkhIaStYMjRZZ2pUSmZjNHVNcWkweTQvc2lZcXk1UldkTFJHY3BQ?=
 =?utf-8?B?R29XWG0wWnNpTlpwNUcxOFdNMGZLck4wRkd5RXpkNjZaMkNpaTJOMjBKeFJ1?=
 =?utf-8?B?RloxMTBqUlFWTEJNbk1wbDAvelNqNUpJeVRDVDhGOGQ4QmVHTzA2WVRJRGRY?=
 =?utf-8?B?NVpkOFMwdzJqWU9FclluaVJHaFMzVldaaVkrWWZtdXZMbXp1dCs2Y2I5KzRr?=
 =?utf-8?B?Vi8rTmVjZmtVNTBKQm9YbzJyRk96MUNPWjZmYjNPa3dRN08wZ0VXdC8vakt0?=
 =?utf-8?B?MDBER3cvQUlITkFwL3BrN0xyRjNWbVZ6dmlZTHdVRU5Uc0dtY2Z6WW82M2x5?=
 =?utf-8?B?dTZLN0ZSdTNpckV3cEpLNnQxMFg3WUFYZjYxN3JiSHl3TUNWL2dsVkc2ZzhE?=
 =?utf-8?B?SHNHNWRMMVRacmx4WlNXcmdqU2s1NFF6M2IrQTk4T29KQ3ZocEJEYUVpNk5R?=
 =?utf-8?B?Ny83M0VVS2FWNEM0bk84ZUtQUVdsQ2NxOCthWTlsdGxuc09oV3o1cXNvWk1Y?=
 =?utf-8?B?cmVQRFlPWDJubnhBdDFRZFRUdVpmTGRtaG95d1MzMVM3UnNLSnVYTUZ6Nm0w?=
 =?utf-8?Q?Y9P8+OH5Ga6nl3XMvt6YkB8/9xppwXQdN27cGtuqMBv9n?=
X-MS-Exchange-AntiSpam-MessageData-1: Bln8lmQoQGVdOg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7322857b-7c52-404b-f9d5-08deb56c407e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:02:48.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVD2qkaNC64neci8tnrQ3k/quiGMzKglR+i6XxqZ+iqVxenTp/mHdCXAWoSEejxwoPMcTkh3PaaPlcGpRxojIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8985-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B1FEA577B0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> From: Gary Guo <gary@garyguo.net>
>
> There are a few cases, e.g. when dealing with data referencing each other=
,
> one might want to write code that are generic over lifetimes. For example=
,
> if you want take a function that takes `&'a Foo` and gives `Bar<'a>`, you
> can write:
>
>     f: impl for<'a> FnOnce(&'a Foo) -> Bar<'a>,
>
> However, it becomes tricky when you want that function to not have a fixe=
d
> `Bar`, but have it be generic again. In this case, one needs something th=
at
> is generic over types that are themselves generic over lifetimes.
>
> `ForLt` provides such support. It provides a trait `ForLt` which describe=
s
> a type generic over lifetime. One may use `ForLt::Of<'a>` to get an
> instance of a type for a specific lifetime.
>
> For the case of cross referencing, one would almost always want the
> lifetime to be covariant. Therefore this is also made a requirement for t=
he
> `ForLt` trait, so functions with `ForLt` trait bound can assume covarianc=
e.
>
> A macro `ForLt!()` is provided to be able to obtain a type that implement=
s
> `ForLt`. For example, `ForLt!(for<'a> Bar<'a>)` would yield a type that
> `<TheType as ForLt>::Of<'a>` is `Bar<'a>`. This also works with lifetime
> elision, e.g. `ForLt!(Bar<'_>)` or for types without lifetime at all, e.g=
.
> `ForLt!(u32)`.
>
> The API design draws inspiration from the higher-kinded-types [1] crate,
> however different design decision has been taken (e.g. covariance
> requirement) and the implementation is independent.
>
> License headers use "Apache-2.0 OR MIT" because I anticipate this to be
> used in pin-init crate too which is licensed as such.
>
> Link: https://docs.rs/higher-kinded-types/ [1]
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

> +trait TypeExt {
> +    fn expand_elided_lifetime(&self, explicit_lt: &Lifetime) -> Type;
> +    fn replace_lifetime(&self, src: &Lifetime, dst: &Lifetime) -> Type;
> +    fn has_lifetime(&self, lt: &Lifetime) -> bool;
> +}
> +
> +impl TypeExt for Type {
> +    fn expand_elided_lifetime(&self, explicit_lt: &Lifetime) -> Type {
> +        struct ElidedLifetimeExpander<'a>(&'a Lifetime);
> +
> +        impl VisitMut for ElidedLifetimeExpander<'_> {
> +            fn visit_lifetime_mut(&mut self, lifetime: &mut Lifetime) {
> +                // Expand explicit `'_`
> +                if lifetime.ident =3D=3D "_" {
> +                    *lifetime =3D self.0.clone();
> +                }
> +            }
> +
> +            fn visit_type_reference_mut(&mut self, reference: &mut syn::=
TypeReference) {
> +                syn::visit_mut::visit_type_reference_mut(self, reference=
);
> +
> +                if reference.lifetime.is_none() {
> +                    reference.lifetime =3D Some(self.0.clone());
> +                }
> +            }
> +        }
> +
> +        let mut ret =3D self.clone();
> +        ElidedLifetimeExpander(explicit_lt).visit_type_mut(&mut ret);
> +        ret
> +    }
> +
> +    fn replace_lifetime(&self, src: &Lifetime, dst: &Lifetime) -> Type {
> +        struct LifetimeReplacer<'a>(&'a Lifetime, &'a Lifetime);
> +
> +        impl VisitMut for LifetimeReplacer<'_> {
> +            fn visit_lifetime_mut(&mut self, lifetime: &mut Lifetime) {
> +                if lifetime.ident =3D=3D self.0.ident {
> +                    *lifetime =3D self.1.clone();
> +                }
> +            }
> +        }
> +
> +        let mut ret =3D self.clone();
> +        LifetimeReplacer(src, dst).visit_type_mut(&mut ret);
> +        ret
> +    }
> +
> +    fn has_lifetime(&self, lt: &Lifetime) -> bool {
> +        struct HasLifetime<'a>(&'a Lifetime, bool);
> +
> +        impl Visit<'_> for HasLifetime<'_> {
> +            fn visit_lifetime(&mut self, lifetime: &Lifetime) {
> +                if lifetime.ident =3D=3D self.0.ident {
> +                    self.1 =3D true;
> +                }
> +            }
> +        }
> +
> +        let mut visitor =3D HasLifetime(lt, false);
> +        visitor.visit_type(self);
> +        visitor.1
> +    }
> +}
> +
> +struct Prover<'a>(&'a Lifetime, Vec<&'a Type>);
> +
> +impl<'a> Prover<'a> {
> +    /// Prove that `ty` is covariant over `'lt`.
> +    ///
> +    /// This also needs to prove that it'll be wellformed for any instan=
ce of `'lt`.
> +    /// It can be assumed that `ty` will be wellformed if `'lt` is subst=
ituted to `'static`.
> +    fn prove(&mut self, ty: &'a Type) {
> +        match ty {
> +            Type::Paren(ty) =3D> self.prove(&ty.elem),
> +            Type::Group(ty) =3D> self.prove(&ty.elem),
> +
> +            // No lifetime involved
> +            Type::Never(_) =3D> {}
> +
> +            // `[T; N]` and `[T]` is covariant over `T`.
> +            Type::Array(ty) =3D> self.prove(&ty.elem),
> +            Type::Slice(ty) =3D> self.prove(&ty.elem),
> +
> +            Type::Tuple(ty) =3D> {
> +                for elem in &ty.elems {
> +                    self.prove(elem);
> +                }
> +            }
> +
> +            // `*const T` is covariant over `T`
> +            Type::Ptr(ty) if ty.const_token.is_some() =3D> self.prove(&t=
y.elem),
> +
> +            // `&T` is covariant over `T` and lifetime.
> +            //
> +            // Note that if we encounter `&'other_lt T`, then we still n=
eed to make sure the type
> +            // is wellformed if `T` involves `&'lt`, so we defer to the =
compiler.
> +            //
> +            // This is to block cases like `ForLt!(for<'a> &'static &'a =
u32)`, as the presence of
> +            // the type implies `'a: 'static` but this is unsound.
> +            Type::Reference(ty)
> +                if ty.mutability.is_none() && ty.lifetime.as_ref() =3D=
=3D Some(self.0) =3D>
> +            {
> +                self.prove(&ty.elem)
> +            }
> +
> +            // `&[mut] T` is covariant over lifetime.
> +            // In case we have `&[mut] NoLifetime`, we don't need to do =
additional checks.
> +            Type::Reference(ty) if !ty.elem.has_lifetime(self.0) =3D> ()=
,
> +
> +            // No mention of lifetime at all, no need to perform compile=
r check.
> +            ty if !ty.has_lifetime(self.0) =3D> (),

This treats macros as not having a lifetime, but it allows this which is
not covariant for 'a IIUC:

```
trait Trait {}

macro_rules! asdf {
  () =3D> { dyn Trait };
}

type NotCovariant =3D ForLt!(for<'a> &'a mut asdf!());
```

And you can get rid of the macro too:

```
type NotCovariant =3D ForLt!(for<'a> &'a mut dyn Trait);
```

These are not covariant because dyn Trait has an elided +'a lifetime.

I feel that the syntactic checking is kinda difficult to get right since
it would need to handle all ways lifetimes can be elided now and in the
future.

Would it be that bad to always emit the proofs?


