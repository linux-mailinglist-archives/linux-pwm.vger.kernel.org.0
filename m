Return-Path: <linux-pwm+bounces-9411-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T20UD1+RPmqtIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9411-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:49:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D88596CE1EC
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:49:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=xIq15vF8;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9411-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9411-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4080F30C764B
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D733FBB76;
	Fri, 26 Jun 2026 14:45:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020077.outbound.protection.outlook.com [52.101.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8D3F9A10;
	Fri, 26 Jun 2026 14:45:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485141; cv=fail; b=kOh0ZY/TkrarSyk/yKsWbmzeA8ggq0WpjssHAewU3JmfVhuIgrEuv18s3tWpL7TCDLA90ccUqhVbYlHoaNPxkQheHf9ngsUbFy4WyQht5PAsDMR/3xxcg3fx6XIHXvCZaqH3qolN7LWBPNptOzygOO9SRgmFIu9BqgfN3grO7tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485141; c=relaxed/simple;
	bh=qeBpckw82sbYev0IIe6VonBU6n0nFLFX0QEig6zubIs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rtyCkak88RrbTAax+p5t6DPQrT7ZCXWR/1y1EllqKzkMuiq160s8Aq5wmImz0Y2NU2ox891q42/niVlApCW4oF0zdZU69BWWtopvJm5T8gm3hyDIDuqZuexHvBIplkso0Khr9vuZta+GLWBVH15XPyvd8emca3VxiHLE+D14qwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xIq15vF8; arc=fail smtp.client-ip=52.101.195.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEbTnKJkiGaTcstDDeQ+qmFOQqamjcHHgQwxSQ5hqeepsa6I9F0PtLvyIC7KUVJT05aySOymtq6ti81yrmHYbYv8oHVtLU6saQtOtDTCNmCDi5Dd+XLcd2Jk8NcRSD4NokvblQCN9GmHvEvGbEgnz0XqLHkkh0mxEKs35IcQwGDzYEqV8sz7Izn1xyFwiH8Ff0y9W2tH/+z39UgUXw8BePT1RntQMADL8Vumki2i2f3m/50IyR5OANYKVV2tF0K+jn8eIiQTjS+PQUTTGjE8UfhjkcijjplNFrZdEZ+D0DHmqhO4QuzNWCCWUoPCwyLk+NnyfyHqwK/oDpzjmMtvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmeVOEKlgvRUrkpGPNIUlitumOHuRaLWpCmaxwQo1L4=;
 b=JsaWXrPP636sf5u5zLuDKX0D7KNlScl0B6+GieYQWU8qoHZvxyw08jAeLkBb10OogXiTg2CHpsYfaln9o2HgGaOlPmFOQyO3uOWmFSAgX9UGbSXkyTI4fQgFgnmp1eizCcX/KVubM+AHyX/dDGFiJV34TZ2udWpvBzGcISieq+yJ+pO4l/RuUyNUngIamiInTv00gwSNLQM7MLKujCoh5g900a966kaB+4P8dhCLyrKU6acJOJOLmDHo20PtmO0wzObYSukFJJPbXgriekyIuUMwwGq+ZxeGA3Q+9Aik3IG6QsQgYA6kRRtpfiY6btfd44I/LgBuM3dZ5MVACjwLVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmeVOEKlgvRUrkpGPNIUlitumOHuRaLWpCmaxwQo1L4=;
 b=xIq15vF8XaK6m4U8G34DwMPz5qjXHeeX043Xt7W4pXc0EL3G76iUndKnAemSJQIb/tE5fkCw0uiKrtjPRiMxAVVCu56vdK8rdp8qu2uxq1N7BhxSLEZbjkFxCL7Hk2yo/M8w/MtH5vuq+X68Q4RlSWOOVoLfkFWR6fWNSd9ACl0=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:23 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:23 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:16 +0100
Subject: [PATCH v5 12/20] rust: io: move `Io` methods to extension trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-12-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=6874;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=qeBpckw82sbYev0IIe6VonBU6n0nFLFX0QEig6zubIs=;
 b=lyMOczjPwjwaLxR2JVcs02VrYjBwoN4VY32p4QNpwDcToGMaRhMCZTuziUgr4706F5FNqnGyK
 TVibOpfpDZ0BFSw4MPt0Rfyx5Ph7a/+ptWylqlptP8aYdPPRL4BsYFh
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2694:EE_
X-MS-Office365-Filtering-Correlation-Id: af027335-2ba5-4c1c-bfd7-08ded3918d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|3023799007|18002099003|5023799004|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	H3f78jXSwz+9p75NAq0UW82/vGLQz6OKkLIX6MWO3jnB7+8IMeoGyNgpc+y+TppfU3GEID/79WBQcXftTDGZnzkd5NneNtUYDLrBpbjAKS1MsoIOFIsXTBPuJM+2Ojrx+MPdbDyZN5Vg7tsl0/hl9iCurTmKn98+rLNced2hwJKVlnftCtn/vaOIbgMaSxbl+z7gYKy1Q56RO8Wzqw88XbEMgDQRApvOlhFmIBTWeAo1T+sw6qSdG02DZsVBYBqHKGNUjA5tiUd8f2IH+OGVq0+ieQh76HeIyoc0JLz8cVo8BPP40up6hf+1zYremhS53ogxMgq6hSw0qSDPvYv+75G1vpV62qHrKsnjhZdhTh3rxdttq8aID02qp5ArljWCYu0QsxDqU4bsMEJqRBX78ZQSnIRJ7HA9AXvlZpBdINr/bXx+Vnxmy9HCsaNgONUpCDazJoSetBWJgB0DQdyBkHveldTcRYfMg4Ogwq5gZw8ihRhmWiA8p320dajIBP/W1AUM0QQinyEknt1R+5e0WbmCZYqjFbrupQOsuk1LS7+MlMIsTikvrA8fB+naOHIXJ4mnrWp1XGsvVXgBWPYW6mGYrStb6ga5JlXr2acHYNVaPq3MWGD58puw1Pg1aJT/RayfcQPHyhnVTE7alVnY4ILlP+3x92z+3rWlrmqPfUov/LimJ5oHmUKhx7DZ6/5sPa7aqx1eekbA5aYoTPecjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(3023799007)(18002099003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVBXVm9VRysvYUVDQzZzWUZQOE10bDYxTHRnbzlXU3ZKd3J0dDIrSUtMSnRw?=
 =?utf-8?B?Q2lDbUtVajNvaXJHZG1nUXJnN1dmQmdieTJaZTBEZ0R1Wld3TGRRTFE2eTI4?=
 =?utf-8?B?S1g5K1BQeHpFUmRTVHNranNWOFlLRDBRQlhKRlpNbmRqVFgyZFRTRTRVcWNl?=
 =?utf-8?B?M0J4TUp1YWxjSzFFVFl3VjdvSXJRelNlY2tkdGw1bzRtYkp4M05pN3FSUTRU?=
 =?utf-8?B?VDg4K20vbWF0ajFXZ015N2RzSmpRRnZuRmo2TS9lREdMamNkNHI3STJlYjF3?=
 =?utf-8?B?YVp5MC9KUFRnbmVRL25lZm15bkNLR0NVKzM2WWZhRHdwaXpaaXVXVzJFVS9N?=
 =?utf-8?B?Vm5RdEJ6b1RUYWNhTFB5b1VoZS9yYWN3eXdoUFh2VkNHOHpCaTB2eDA2cmlh?=
 =?utf-8?B?L1FwU1h1Z21SUjhONXR2aUoreFpQMk41UTVRV0ROVnVqd0dYWHBQVDRzYWJI?=
 =?utf-8?B?cEFFVkltZGR6ckJtZmRTTGFEVU9SZFUrdDgzQTZWckViemhIMk5CMkdxbEMv?=
 =?utf-8?B?aWp5RTkybkozVVBmYXgvSGpFTjRlSVVKcXNvbE1odGhwRWtSQWZVMXR3SlJI?=
 =?utf-8?B?bldNbFcvY3owaVB2WkpFQjgwNlAwUkJyczRCMzJpNDQ3VGd0b2NUVjZWclBZ?=
 =?utf-8?B?OEs1azRLY1doSlgyblduWHFWSkE1d3R0NEprbHZRdERBT1VpbDN0YzFpTVZa?=
 =?utf-8?B?MDU5VzI2WmtoeTFlNDlsYzNJSmtjV29rUm8zSmdIUXQ1azhXdms5Tm9NeG1y?=
 =?utf-8?B?QitLb0pZWHhXYTY0MVZ1MWIzU1NZbEhsZGdNSHNSNUtXNEc2a1ErMUNGUG5B?=
 =?utf-8?B?dDh5WS9YU2pxK0RjMWlnMnVtSjNGQ3Y0TElNSUYyVFh1ejRhTFFlVUh1Z3FV?=
 =?utf-8?B?cmhoSzVHbEE0Q1F0M1FZOStHMWpvdmhPZS9ORi9lTmtBNG1DMk42dEFPTHZp?=
 =?utf-8?B?T3g0Z250MVN3bHIwU0JQZWFoZUhPRTRvT2JHdjRLQUhkWWtLakhOUm91NEZu?=
 =?utf-8?B?MUh5dDlMVS83a2s0NTBqN1JZTDFzcE1ZSllvSHRyTFdXbk96T3RxZEtNOEZ1?=
 =?utf-8?B?WnpmUUZ6bER6VHdId1Q1K0tETS9KNEVNRnBicC9HRUJvMTArMENDa09nSjdq?=
 =?utf-8?B?bEQyaFJLVUJobmc1dGhHdVAwakdKQUFBWitlZUlhUHZTaHV1YWo4MGNyVzRi?=
 =?utf-8?B?OHlSdkZBczYvc3JRaHJMTkppMWYyU1FmMGZpQ2VrNnhIcnlJV2l6V0NQKzFN?=
 =?utf-8?B?NVBIeXViQURBZUJqOW9aMnJUZkpQRU9lM2gxbE5uZlRKN2tBNDZKOUdIc0tO?=
 =?utf-8?B?cTl3L3BXaGN3VVQ0YzVIR25PdUJBM1VlMVU4WENsc0ZtZytFWWIvdnlBU0xy?=
 =?utf-8?B?emFnL0NwTWNlNjh2MFVsa1IzWG1iK2Mxay9BTmxvcGs0SldvK3RMRWlYZ0sy?=
 =?utf-8?B?c3RHeUZUZ1lteFNIUGlyVmRjSS9XUjVMeTl0aDJsdmN0bVpjSlhzTWJvdVRW?=
 =?utf-8?B?QjhaQXlURGNpaUVXeDFLdjlYaExETDVUMUwybUt3VmlRZTZNQU1Xbnh2WWxN?=
 =?utf-8?B?M2RHeEg3RXY3Z1lhY3UxUzROSkhZUUZua3YvZWE1OW90MXN3RnA2UUJNbExV?=
 =?utf-8?B?L1VLbndqUkROVjhCRUgzVDJIa2tKMktKbm9idlM2ZFFuWU9KVGpNU3VKcE42?=
 =?utf-8?B?UDY4SmpydXlUVklNcnVab25qSisrKy9OcXB1TllNaTkreVY5SnJoZmJRUmNE?=
 =?utf-8?B?SERDd0VtRnUxQ3VqU2V5Ym9CaVdLTDMvbFk5Um93cXhpa2MrRDlZaG5tUDBB?=
 =?utf-8?B?NkgzSjhGZ1ZpWWtxVUpkTjI1ZG9wMEM2WUtMQTB5MTh0aU5MTVZNcEpGK3R3?=
 =?utf-8?B?cVlycnNsRlMwSVAva0xTdnVocmJUNTVkcDNNVlJvV3ZQUWZHNGU4YnV0cmlG?=
 =?utf-8?B?S2MrN0RQQkhUc3lrcDJZUS9ETzh6USs4RDNaS3dzazBoOXFvcXVlT21EZm1R?=
 =?utf-8?B?UVlmZk16M25pL2hOb3NwVEl0Myt6TURZYmUxM2xFVUZQcWJTUHVOcDA4Ujlu?=
 =?utf-8?B?S0dHMHhSYUFES2czVy9TeVFkc2p4SkUxSTB6Qkg0RXhOaHRJUEppaFRWdUp6?=
 =?utf-8?B?MXVQUEY5QVV2T2dVenQvY2NaeFYxS0lEZ1kvMnlZaDBuT0VIRjBSRGlRUlZZ?=
 =?utf-8?B?WTVKaGsrV05CMFE4V1ZPVzJJaURBZlJMdzFtd1ZaQTkyd01pSFhJMnNRZHFT?=
 =?utf-8?B?a1ROUDJrbGVqL1NuM3phcW0waUhQU0NBM3UycU81OGlINHI3V3JDNUJDK0dY?=
 =?utf-8?B?cWdHazIrV0VTY3FyYkZ4MHVZeHFaK3ZtWjNhN1dUOHBrRnJTRUtZUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: af027335-2ba5-4c1c-bfd7-08ded3918d81
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:23.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtZv2TBF5p5+hsIFwaPv8ieFCeDaTtz/u6X+j+Qn4vfu/IyDPBVK5FbmzCDikvUxMrMF+lAhVkITRYAuM1KjUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9411-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D88596CE1EC

`Io` trait now has a single required methods with many more provided
methods. Provided methods may want to rely on their implementations to not
be arbitrarily overridden by implementers for correctness or soundness.

Thus, extract these methods to a new trait and provide a blanket
implementation. This pattern is used extensively in userspace Rust
libraries e.g. `tokio` where `AsyncRead` has minimum methods and
`AsyncReadExt` is what users mostly interact with.

To avoid changing all user imports, the base trait is renamed to `IoBase`
and the newly added trait takes the existing `Io` name.

A `size` method is added as an example of methods that users should not
override.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  3 ++-
 rust/kernel/io.rs     | 34 ++++++++++++++++++++++++----------
 rust/kernel/io/mem.rs |  6 +++---
 rust/kernel/pci/io.rs |  6 +++---
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3545ffc5345d..6e0b845b229b 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,6 +68,7 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
+///         IoBase,
 ///         Mmio,
 ///         MmioRaw,
 ///         MmioBackend,
@@ -105,7 +106,7 @@ struct Inner<T> {
 ///     }
 /// }
 ///
-/// impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<SIZE> {
+/// impl<'a, const SIZE: usize> IoBase<'a> for &'a IoMem<SIZE> {
 ///    type Backend = MmioBackend;
 ///    type Target = Region<SIZE>;
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index adafd273920f..0746b0d209ef 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -223,7 +223,7 @@ fn io_view<'a, IO: Io<'a>, U>(
 /// operation.
 pub trait IoBackend {
     /// View type for this I/O backend.
-    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend = Self, Target = T>;
+    type View<'a, T: ?Sized + KnownSize>: IoBase<'a, Backend = Self, Target = T>;
 
     /// Convert a `view` to a raw pointer for projection.
     ///
@@ -309,15 +309,12 @@ fn offset(self) -> usize {
 /// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
 /// can perform I/O operations on regions of memory.
 ///
-/// The [`Io`] trait provides:
-/// - Method to convert into [`IoBackend::View`].
-/// - Helper methods for offset validation and address calculation
-/// - Fallible (runtime checked) accessors for different data widths
-///
-/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
+/// This trait defines which backend shall be used for I/O operations and provides a method to
+/// convert into [`IoBackend::View`]. Users should use the [`Io`] trait which provides the actual
+/// methods to perform I/O operations.
 ///
 /// This should be implemented on cheaply copyable handles, such as references or view types.
-pub trait Io<'a>: Copy {
+pub trait IoBase<'a>: Copy {
     /// Type that defines all I/O operations.
     type Backend: IoBackend;
 
@@ -326,6 +323,21 @@ pub trait Io<'a>: Copy {
 
     /// Return a view that covers the full region.
     fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target>;
+}
+
+/// Extension trait to provide I/O operation methods to types that implement [`IoBase`].
+///
+/// This trait provides:
+/// - Helper methods for offset validation and address calculation
+/// - Fallible (runtime checked) accessors for different data widths
+///
+/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
+pub trait Io<'a>: IoBase<'a> {
+    /// Returns the size of this I/O region.
+    #[inline]
+    fn size(self) -> usize {
+        KnownSize::size(Self::Backend::as_ptr(self.as_view()))
+    }
 
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
@@ -779,6 +791,8 @@ fn update<T, L, F>(self, location: L, f: F)
     }
 }
 
+impl<'a, T: IoBase<'a>> Io<'a> for T {}
+
 /// A view of memory-mapped I/O region.
 ///
 /// # Invariant
@@ -819,7 +833,7 @@ unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
 // SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
 unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for Mmio<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for Mmio<'a, T> {
     type Backend = MmioBackend;
     type Target = T;
 
@@ -920,7 +934,7 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     }
 }
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for RelaxedMmio<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for RelaxedMmio<'a, T> {
     type Backend = RelaxedMmioBackend;
     type Target = T;
 
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index d9b3189d09b4..e95b769ebe47 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -14,7 +14,7 @@
             Region,
             Resource, //
         },
-        Io,
+        IoBase,
         Mmio,
         MmioBackend,
         MmioRaw, //
@@ -210,7 +210,7 @@ pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a ExclusiveIoMem<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a ExclusiveIoMem<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = super::Region<SIZE>;
 
@@ -292,7 +292,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a IoMem<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = super::Region<SIZE>;
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 4be33ecb4192..4d1d0afdc491 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,8 +8,8 @@
     device,
     devres::Devres,
     io::{
-        Io,
         IoBackend,
+        IoBase,
         IoCapable,
         Mmio,
         MmioBackend,
@@ -144,7 +144,7 @@ fn io_write(view: ConfigSpace<'_, $ty>, value: $ty) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for ConfigSpace<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for ConfigSpace<'a, T> {
     type Backend = ConfigSpaceBackend;
     type Target = T;
 
@@ -267,7 +267,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a Bar<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a Bar<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = crate::io::Region<SIZE>;
 

-- 
2.54.0


