Return-Path: <linux-pwm+bounces-7785-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6A9CAD9EA
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 16:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA965300F1A6
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FA529C325;
	Mon,  8 Dec 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hxAlssks"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011005.outbound.protection.outlook.com [52.103.1.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF1323D7E6;
	Mon,  8 Dec 2025 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208441; cv=fail; b=lKD7SIE0Xlo8ePunQnueyBXtsxK4hfbsfEdS98HaN5NfM0+cPqo/tbtszAQTRnvZDC9XOQEm12dpYMUrvnEq4NafeVLS8AQylLdNczh6ZnAVIItkEQ38AjqqfcUvJYXZoUvLr37cq37yJPbm7+j7SMRmkL+dV4gHUcaHNJGRcUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208441; c=relaxed/simple;
	bh=K7E/ziCqJmI6+aPFxBDWZ+cH2Pyap0YjCR2tNXDT+t8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GpA8Zf4wMYD8ghs7ey0N8rkKvegCp8kZIFYyWPS9oD2pVIPnhgmECkPOQAxWWnML3HocprZgR6uSdUlPlVNG9G+iRB2riVglm5XWx11+eSjYKS7O9CkSLaINopG84fvubYwiv0SXxq7u0HvzD3vz+rKYi8tQZFb+sr1VjGsnb8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hxAlssks; arc=fail smtp.client-ip=52.103.1.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKzisNY9Lsw7mmfyzfHU6I2rUUFZypggFI0hfWh/Ftt6ai5AK4+QOg86rpgThYq2A9kO68L6GQeD4H3VpJSkNvGpRc1r0/yILliKFQwxqHbB+vIrITL9Y6atfbaXVqXuTwATImTrD2IRne1yBmWK4tC5xWpwDpKBN1DvSqTso3NPWc+k4oClvzPnND0JQgV6B8BfbDyb+0qbdnCP8M4fPNqovQkrP/JJ3vGDnKfiFV6nx6d27Ih7fIeEpoEnt2lu2Bq+seFc4Mwc3PM9BKEysqhLHwX3Kj9GPuvVN/a+Pugco6qPE377AkshHq5Ewn0/El2uV0zVr5Ye3v5vPrzfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvZKKjWxFA2hwo1QBIqN4Ir8pc5huAjH3/GH1UhgSsc=;
 b=CrW84ldA4uyyCpVko6e2KJ4rDXVry3QAgpoO7rvicK9xkUGZnh9AsgBTvHJiDMa9WwbY3C5PUb6GWWBcu1Y+EUf1W1ZibixhyLdQqr5/npx6ic/fi55rcKz66iLzd6lXPpEraQ67svWPklvCy0fJ+3azunlVh6rI3PgGC0NTmK2SODcaR7LOWaK5jJSNI54yiJrotnvBYEs7ZipMeZ9gkcwWf0Iu60RvmmZw8bjMH6fIop+2KVUD8moCzwhewdwsJHkgWYNiqrIhejIXHdSbHyS3FSagRcencCaxU6TPtl9Rj2zaOKDbfm5XIk/Q7o3yKqRfp9GUzA/yH8Qrz+WpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvZKKjWxFA2hwo1QBIqN4Ir8pc5huAjH3/GH1UhgSsc=;
 b=hxAlssksyi4MsXW/KGcJopbwkTtsHHy8Z3aHTzsK864ZyrOmU/v2t50EUqwhkdw3HoRJp2KaL/0vxICA8a53YhVhWz+a94zYnv5AMfnvnVa56VY7F6LeFGqdOpDyULktntuKmWkJ9U4rWPS+l67cNE7eu+JbPH1mz3pdPtU05CC36jwwNcrKChDhYAd5RmXS/pQTfgsCVugSMjcQBECpetPjWSrSDDxk5Fy5FrckdqOzcIjZ6RpkdU6UCl2q7Rpv4lsXTqc6GrrDydyUWVmFMu7dqS0w9hK8hy2GJp1iy+bBKi+Ij2PvE1tlPsS+GjRPTZuQem/YjMw+xAFy7mKo3g==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV0PR19MB9333.namprd19.prod.outlook.com (2603:10b6:408:320::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:40:34 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:40:34 +0000
Message-ID:
 <BL4PR19MB8902F80FE2D7FD5BCBE340689DA2A@BL4PR19MB8902.namprd19.prod.outlook.com>
Date: Mon, 8 Dec 2025 19:40:21 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/6] pwm: driver for qualcomm ipq6018 pwm block
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Devi Priya <quic_devipriy@quicinc.com>, Baruch Siach <baruch.siach@siklu.com>
References: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
 <20251128-ipq-pwm-v19-2-13bc704cc6a5@outlook.com>
 <3aa86b13-9505-4f64-a168-4c46962b715e@oss.qualcomm.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <3aa86b13-9505-4f64-a168-4c46962b715e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO0P289CA0004.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:20::12) To BL4PR19MB8902.namprd19.prod.outlook.com
 (2603:10b6:208:5aa::11)
X-Microsoft-Original-Message-ID:
 <3d992b8c-388f-4a6c-b648-3e4624ec5c39@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV0PR19MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: f1724981-d902-4ff2-f013-08de36701ecf
X-MS-Exchange-SLBlob-MailProps:
	i0w2f8qhTbpLSAmUKj360lG2FPdsQaRS8oeF5S9RL+fdONv8z5t0waexnQg2qC9C0C8T5U/5TqniaiR2ame6p0YLBTI1y3lq5CWAHJOjdt69Bg16Ws/KxR+8+4zOk1pcMSfBhVZv8jUpSsNWJd3ZtpnDFugYslZaynbeRcIKdnZF5Qg+qJeqi3RhqY9Pl5S8MyFDoNZKH4Lj4xCvHi91gsegl6zxAcQ40u+Lkpx01+KUjyPA3NdVi8vWAkZzByhThKhJs3OGaYeefse6orMixmcOfsffSLypjo9dIw2or5cmXDYmPnnLpOhurR3KMZVt6qofCOACz6QY8mcEddP+trPA2rFDeXKZC87qOdFWSpknmxDAY7S99Dp9AF54GyqrHE9P49I114pEjtXfC7ASG0EIe7cuON9QwSQ4LY25lQMXwb6bBtTFky5bE9OofdvezYxo29bppuTnRYz7aP7bPW1+O3fDk0eJhMuiy8+F9nebhvBpba4MGNiE1AIj94/6rXsRWShTQd0AFD+yHJCmXO4Y2Ead+iVCvx1pjcGJjWsRPXDm0ZR4RgorKEPqY2VX6cs4eo2ICWYH5400byhEGPXgJSkNYLlDKCZR45+/jyHnxBja2ksukZjU6XoPQxY99RB1OJJzj8LyKai3it3grTiZQSMj5y2UUOFrAVslRX4sQwgISfAsdBbI7+AKe0gpkQ6rPwTDbm+zy8X2W1B0b0SkEBwXbqV6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|6090799003|8060799015|41001999006|5072599009|23021999003|15080799012|461199028|19110799012|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THdXVDRIaDdKNlA5NjBCUVB2OEFucTFNb2I1NVd6RG00bUh4WkdBclpWS3pY?=
 =?utf-8?B?LzlJbjNvZmhjeG9mMXZnQUR4QlQ4RUNzeWRFVVlrUUlQSXU0cUYvM21pT3Jl?=
 =?utf-8?B?dFR4R0phK25IZHZnSDA3TlJyMUZLdjJkNk53MWJKZXl0bVdjelhQNUxjblJK?=
 =?utf-8?B?Wks0K3p0V3lRSVBwSVdpS254cVFHOWhPOUtPODVnWG5hc1gwbVF3elNMakNL?=
 =?utf-8?B?VWR6R1YvbUdzTWtRd1Y0aHA1cUE1c1puakZvdklRSHdrYkxmZGxZZU9mMllu?=
 =?utf-8?B?QjJYck9xRmNhWUdjbU5lclNrYUtab0FMK2hYeWgrRldJQ1hUQmlMSnBGc3ZX?=
 =?utf-8?B?RFhDZGJ2RzNRVmpOWnU3QXZqN0ZsYlFzOGJHZXhoZXFIanlkK2p4M0hocHpr?=
 =?utf-8?B?bFIwZG50VTV3eEx5WVZkM0RIRWw1RkhZYkhqM0R4TGxMRkhYQzhFWnZ6U0d1?=
 =?utf-8?B?VjR4bC9taGdKMXkveDFyWnFoQVRrNnBiUE50dVVldXFldVhQSURPS08xdHI3?=
 =?utf-8?B?TFRWSjJLQVduTjhlWnlQZk45TC9ydmdrc3dWRWRBeU96b3ZGcVE4SXlSQ1h1?=
 =?utf-8?B?M21ITG84MVZGbU1oV0czVU1QQm9iTi82R29URy9QeUxDMHdwL0RSRHN6eVJi?=
 =?utf-8?B?Zzk1OUlPV0FiK094cDYwUkIvdVdXTmdVNTBiK1dMbmNnL3RTanl3b1E1dmpD?=
 =?utf-8?B?NkE5T2k1dWdnSStGMzZRRlA2R3QrcTdITVErQUg4b1dxTENEcTh4STNOajNE?=
 =?utf-8?B?TTB4cFJHYmRYUVRKc3RYN1NpdEZaQkZnM2djTzAzK1FlTktSaTZuOEhKQzRE?=
 =?utf-8?B?RW5CMWs3RmlNU1hSQ01nNDEzRHg3aDBhTWNuUUNZQ3Zkamt4a0JwQ2tuOFlG?=
 =?utf-8?B?UFZaTkhPTXZOWDk4ckhyd2FCVFZJcUUzTnNyWGQ2R056Qm9CUGVOaENTSER6?=
 =?utf-8?B?U2hVWFJaei9LekxzNzJReGdFbGVteHVDVnZWaFFlNGdWeXNVNmNrajY3UnFI?=
 =?utf-8?B?SGk4c2RQR0JJMzFwREIreE92TmRYVmd1UlAwdzdKRTNGVURjZEtqdGVDdmZ6?=
 =?utf-8?B?bHRZQzVxbjRUWm5mOXBDbXlmYTVwMTB1Wlg2dStrdFJSQXRkRDd5ck5mQkZH?=
 =?utf-8?B?Tm1waFdZMkwxalE0TVJDbXZyVCtqSnpON3JTaVJiT2VJT3B5bnVxUFdzbkF3?=
 =?utf-8?B?ZU1pK2x6RGg0UlpDTDZobGdjNUV4OG9iZzBNWWV5NmhMZVlHaXQ3dHJiTFB2?=
 =?utf-8?B?SGIvaXlha1ZxU3E3bFd2RHJJTHRCVGd3a1dzYVB1ZFl4Q1BVN1hSVUhkMFlN?=
 =?utf-8?B?eTVKNWVGbGgvTE1BTzRmZ2t3OVBUM3JQb0wvRVAvUDdjMGpvdk5NV1l6WnZ2?=
 =?utf-8?B?a3dLSWRPMk1abW1qZnAxUTVqKzJPckJBZWp1ZjRPcTBheFNCUlNHN0RHTUdz?=
 =?utf-8?B?RDU0QWc3VnRtMEVTZWhNWG1td2syQkhGcVNUL3M1MUs3bUR5eDgrSjY1QVdm?=
 =?utf-8?B?U29KVXE0eTFzNlJ4TDNyRGtzSlRjVGxNZlMyZVRTdnRQejM4NkJnQS9UYUk4?=
 =?utf-8?B?bkszWlFWTURXYW5Kem1oeFRDc2swbmtTVGVSNk1kamNoSkl5SGpwSFBKZVpF?=
 =?utf-8?Q?PtPqrJBLX8y0YkEIS/lW05Gmu0gjn4tFOmMO5r50Qplw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2hsL2VEZUJyWjROY1BxcXBxN1JZSmpwWk5YR2N6R0tERFhDODhFWlJpbDFj?=
 =?utf-8?B?bi90L2dML0doSXoxc3BoVjkrQzNqNWErZk1VS21NOWRsMnBYTERTNkRWSDhW?=
 =?utf-8?B?MmlCYnd3ZmdDNFh4SHJSNVhWMlZXU3A0K0VES241eDJmNi95a2ZjSjY4UVUv?=
 =?utf-8?B?VGhXSGsvaWRucWV3VjdDeVBvQ0twaTRyMEpqSStxemNPSmRKME03bWlXZmNt?=
 =?utf-8?B?K0NHS0EzeitJak80NkcxNjRFN1huK1ZJNjBQV1hIZlpJN0hNeTlOV2lOSzlX?=
 =?utf-8?B?TGxuUmJoM0lQMS9VekI5RUlFdGpSeTd5TlFrN2x1KzIxRndSUjBzdmZ6c0RH?=
 =?utf-8?B?NWhiQXFVNlR3TXRjVDZZODN4bHQreStRL2I2V0JiN3VlR0ZGVkJLUHhQNVdu?=
 =?utf-8?B?dnQrb09qTXU1RGJOVCtYdWVMYnFsMXAzM1FCTnVWZW9OZkViU2w4Mm1MQWxS?=
 =?utf-8?B?NjFQQ1VrMDRQK01IUGp2REE5OFREb1BpQUdXM0RzdHlOOVlqanhPSkhQSWZP?=
 =?utf-8?B?QUE2K21aWmhlMTdKVC9rUzlwN20wQWdrUlkvREV0M3BKbnQ3VU9iSktTbGNJ?=
 =?utf-8?B?UndQTFVMdUNOcEpqczhnWUEvdjZDM0dTam5lcm5lN2N3Yy95dFRVNk9SaGow?=
 =?utf-8?B?M0VVeHZ4dDAxa0lOcG8zdWN6NFkwcnhVQko2anYycWFDanc2Z1R6VitBNTZp?=
 =?utf-8?B?TVFPNWs5TzhHamJ2dXdrLzQvL3NtcUducUNYQkU2NmhMZlVERk5KN1VkSFc0?=
 =?utf-8?B?VXg4MEU1bzZBbzBmTnVUNzBTMzZTTEI2WGEzYzFIOVBNdUxLTXIvZ21GMVhS?=
 =?utf-8?B?NUpsMG5INFI3S1ZJSGlFc1Q1SFdPZFpNMVlyaXZNTHhhOHZuVkgzUi9uQno5?=
 =?utf-8?B?RXRHUktScXNRRnB3VG9mcUNoSGJvdVBtNnNRUHFSNUVyR3pmVUJQakJBb2pv?=
 =?utf-8?B?clBPVzVtMzVhRVZ4djNTWFBOUUU0WWJESTdUUTAwRnB0Y3ROeVJKRko3ZFJt?=
 =?utf-8?B?MnlHUWtwblR3RW9xVnBUVFAxTXFielh0aDZxMndhR1NmaFN5MllFYTdrUS9K?=
 =?utf-8?B?NzNUU2VZdGh4QkxvaVUveUVhRXJ6OHpsYUFpdEJZZ1VqaDhzeUhpaWZoRkNw?=
 =?utf-8?B?ZnZnT0tjdTNBS281VEszdWFoM3BweGJoOFZMWTQxRGlaRVEwcXhXdEdXekFG?=
 =?utf-8?B?eDhySUUyQkk4Qld4Mk0waGpUdWI4ZTZpK0Mzdi93bTVjejk4YVljQkdCZUpp?=
 =?utf-8?B?b0R3MzQ0clFkTkwxNUxsdEpCdUQ1WWlIY0FPTys3VGVyOTUrREt1eURSazJE?=
 =?utf-8?B?Z2VrTlFlNjMyOHhNUWx4eUlYajBEYVNRVlY0bVM3YUZYK1Z0REFpU0VXbVhM?=
 =?utf-8?B?Y3QwNnh0cFVrdEF5bVY3MmVOSFZEeUgya00wWkt0WUtYTU5sL2NXUWJoUHZy?=
 =?utf-8?B?UFlibFBTdHNIRW4xV0NOQkJydTdMemd2bys2bzR0ekZnR3J4RHl5THRkMkRz?=
 =?utf-8?B?dHhmZjlZUnFZMTBrM3FQaWVqOUVlbHB2bTVoazZOWWpVaGg1bmh4STNuenVh?=
 =?utf-8?B?dWNneW41Z1o5UGk0MnZ1bGRRMjdXZWFLZmdBOTRDYXFENlZMZGo2ZHJhemEw?=
 =?utf-8?B?YUZwUXhwM2tNTjZDT2lkelJucGtoVUNveXN6Z3hPdm1BclVJbStyZGQ2Mmpn?=
 =?utf-8?Q?RtVJRdj3xu9SaVrGyMbH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1724981-d902-4ff2-f013-08de36701ecf
X-MS-Exchange-CrossTenant-AuthSource: BL4PR19MB8902.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 15:40:34.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR19MB9333



On 11/28/25 15:32, Konrad Dybcio wrote:
> On 11/28/25 11:29 AM, George Moussalem via B4 Relay wrote:
>> From: Devi Priya <quic_devipriy@quicinc.com>
>>
>> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
>> driver from downstream Codeaurora kernel tree. Removed support for older
>> (V1) variants because I have no access to that hardware.
>>
>> Tested on IPQ5018 and IPQ6010 based hardware.
>>
>> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
> 
> [...]
> 
>> +/* The frequency range supported is 1 Hz to clock rate */
>> +#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
>> +
>> +/*
>> + * The max value specified for each field is based on the number of bits
>> + * in the pwm control register for that field
>> + */
>> +#define IPQ_PWM_MAX_DIV		0xFFFF
>> +
>> +/*
>> + * Two 32-bit registers for each PWM: REG0, and REG1.
>> + * Base offset for PWM #i is at 8 * #i.
>> + */
>> +#define IPQ_PWM_REG0			0
>> +#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
>> +#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
>> +
>> +#define IPQ_PWM_REG1			4
>> +#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
> 
> Sorry for coming in so late, you may consider this as material for a
> follow-up patch (I *really* don't want to hold off your v19..)
> 
> I see that on ipq9574 the registers are named:
> 
> base = 0x1941010 = tcsr + 0xa010
> 
> 0x0	CFG0_R0
> 0x4	CFG1_R0
> 0x8	CFG0_R1
> 0xc	CFG1_R1
> 0x10	CFG0_R2
> 0x14	CFG1_R2
> 0x18	CFG0_R3
> 0x1c	CFG1_R3
> 
> CFG0 and CFG1 are what you called REG0/REG1 and Rn is confusingly the
> index of the controller/output
> 
> The other bits in CFG1 (29:16) are RESERVED so there's nothing you
> missed in there

thanks for your review and validation.

> 
>> +
>> +/*
>> + * Enable bit is set to enable output toggling in pwm device.
>> + * Update bit is set to trigger the change and is unset automatically
>> + * to reflect the changed divider and high duration values in register.
>> + */
>> +#define IPQ_PWM_REG1_UPDATE		BIT(30)
>> +#define IPQ_PWM_REG1_ENABLE		BIT(31)
>> +
>> +struct ipq_pwm_chip {
>> +	struct clk *clk;
>> +	void __iomem *mem;
>> +};
>> +
>> +static struct ipq_pwm_chip *ipq_pwm_from_chip(struct pwm_chip *chip)
>> +{
>> +	return pwmchip_get_drvdata(chip);
>> +}
>> +
>> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned int reg)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(pwm->chip);
>> +	unsigned int off = 8 * pwm->hwpwm + reg;
> 
> This magic 8 could be #defined as IPQ6018_PWM_CONTROLLER_STRIDE or so

good suggestion, will add it should another iteration be required.

> 
> Konrad

BR,
George


