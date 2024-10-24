Return-Path: <linux-pwm+bounces-3796-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F25C99ADC63
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 08:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816B61F21DAA
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 06:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE9189F2B;
	Thu, 24 Oct 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="XpOnYsYS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020076.outbound.protection.outlook.com [52.101.171.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F62189BA9;
	Thu, 24 Oct 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752074; cv=fail; b=LjZp6qdB0MTtauL7WcIX2QyaS1c2iv2ov4nNztMx4sFUvzITj8ZdJRbcR373ShhCMqSH/58H8T8pZLxQxcJpg3Fyq1IeJnERVEMEAYEJ5daLknBqRPhGhAhPAq9omu7JxqyTyOaYUw1RQidu9lD8i3HhDUnBtmPJvAyCVftA51Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752074; c=relaxed/simple;
	bh=hRNOL5XpGlVSzOq3QI/vy8MF5IWP9GTtd1XVNTAOl1w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pC5twX4F/ZCQlP1M1YQqQkF1ULTyeWQ+EsmQD8VPNVWReNANl/IlLEzRpSD0uhm9tUe75bAlTfwv4hN4y/7QpGt6Fb23xhfp0VnjwFmEebO9GHBS5XorJMD0KJ2T/t4bpDC52zI307Ooinuna3FG3JV6UauSVFPYvDNH/lT5VWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com; spf=pass smtp.mailfrom=iris-sensing.com; dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b=XpOnYsYS; arc=fail smtp.client-ip=52.101.171.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHkFj/kc2U91aJZXN+K6cS8cucX2qQm1v9TvU9EgH77IUjk6oeR+SQdXTaLKenzvPzM+nzT2VEkfxvujVInP7CF5wqGBhfkiPok27w/k7fJ2ku1+MK9v98wMSFCZfK/DkfLnuAEBydE5OCckij9Dqvtl03Ao4NBr5SMcMXnG5DX5a7HdgGcQS6rEAfOJjFSa4fgWVDfMB19U/HM9ts6BY9icpDSc95kKARgrxmLh+yatyl2j+M9xSt7rAA+eYwd6P7mVRTtgBjec7YvnqJgX24iHuC30Orc5Hy0eZbbBeyYP6IMx99HWfjF0g6FNAxx+D0c40KGyokdSNRq0+3Peuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRNOL5XpGlVSzOq3QI/vy8MF5IWP9GTtd1XVNTAOl1w=;
 b=iSdUt6ZjMlTKfuhPEYX6Zsxd0ULjScFGSSN2ZlNb4Dp8I5iCWh6ifRYruTz17QeZ5JmqxObl/ygxWQTGS1Wr1HK8M1eRMRAWc/nNYmjMkk4Q6mK+TME6XFSDUdPrOHLee9VsrCp5eKONx2L3lnrzULM1p2IWfJwQKJzETsj8ztHbekC6HqzoMCjl2QZ2cHRJbp1ZXu2o76xclG2O8+Dx/BaK4bR1+45DSgxt5gRRUhgKH6MgRVPjPuuy3xx55jkcdEaDY7EgP23dB5pyEMA92m6J5G7L2JEfSoFdfKvWyp3EGH7zZC3zjPP7s+GCy+OHDvJICSkFXaBr2ol6sioWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRNOL5XpGlVSzOq3QI/vy8MF5IWP9GTtd1XVNTAOl1w=;
 b=XpOnYsYSAzzgfn+tNLGAMTWyLIRcjrBAGCaIiKA3FAM0RMa7n1psUOeAiMUPyXlBY7JW3qM41C4xv0V3sLcyQahsE/FbU46/1WfuO84xgdyj3+q6pkWMsU8PdlJt8uFaKrZ6oQanrsTaPbcttEafrPHmahYrUAlTjGPw3ud4Rvd3/rIUR3+rMWNBRmjM0oKx/L4BEEoXoyhQD5wX4Z7ZXciBI17FQCJTuT5K3EUbY3unm6om26OAaOr45uUt+fmekWsiEJpvx8WTTvFVqfhf+5jZGpEP0Sx1vndRuKle5amsAOMbFyVfHbJFp9Av5dPLZ/aS2IXL9wZVg6dERPWsFA==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 BE1PPFAE0A1427F.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::68d) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.19; Thu, 24 Oct 2024 06:41:09 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 06:41:09 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
To: "ukleinek@kernel.org" <ukleinek@kernel.org>
CC: "anson.huang@nxp.com" <anson.huang@nxp.com>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: [PATCH v2] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Thread-Topic: [PATCH v2] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Thread-Index: AQHbJd+0DCsBjEpWYE6MZa3vNXpdIQ==
Date: Thu, 24 Oct 2024 06:41:07 +0000
Message-ID: <91bfd0c1726d2e6d10c96a3f2e141a7315b08467.camel@iris-sensing.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|BE1PPFAE0A1427F:EE_
x-ms-office365-filtering-correlation-id: 76c87cdb-900f-4eab-b3b5-08dcf3f6d80e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?enVsNTRVTmFob2FZaE52ck8vaS91ZTJxei9qOVhtWXhNbkdYbVVpRXlORWVs?=
 =?utf-8?B?SEloU2p6VEFBNUZTbm9YWnBhSW5oRXNtcS9GYkFydXB4YVRaV0h5cXFWNmhj?=
 =?utf-8?B?aTF0T0hnaEVLSDViUHN2eTg3Rnd4eUlOUndNY3VNNlh2MUhBVFZRaVN4NkxC?=
 =?utf-8?B?cXIxcURPTldZT0VTWVU3SGs4NlNZb0xROHhWTGxJMTZpdXhnUlY1cElla2la?=
 =?utf-8?B?VmxLU0lGQnhmMkpsZkNRbnkyV0lNNjEveG91K1dNaE9TVXBQalBuZ1daZENX?=
 =?utf-8?B?UVpqM09EL05tQmhWQjBPOFVPbmtrZnJIYzJUaHdPU1o3UnlndUdWVTVPVXBv?=
 =?utf-8?B?SnQwWVZPR0lJVVI5T2ovTmJYZUR2RU1JR2NzMjdlOUF0bjhEbU0yWXByMmlR?=
 =?utf-8?B?bU9VYVNwRUZYRVdHQk1SaSt3eWhXYUYyVGMyQmpsSEJSdjlQMmpPNTBTMjFR?=
 =?utf-8?B?Um5wV3lCZDVEMEdVOWo4SzNWZmc0WGdBVW55L0dzb1VFMXhkTkpnN3FiSy8y?=
 =?utf-8?B?b2hMSG1WaUp0MHpicytHS0RhK3B0M2IvbzFPN29vSVFUeXdicTFHT29lam1m?=
 =?utf-8?B?RWxkUzZkVUFQbXBPdjVGRWFJQUxrbml4Z3RVaSs1ZVRaNUtrSVdGZTUvdGJj?=
 =?utf-8?B?b3lWaUFVMm9RQWliaWtRd0g0bW1oR013WTRGM1VoZ1QwRGxXMmNlejdaVUNK?=
 =?utf-8?B?aHRqV1NVdmpvR0tvT1VMUElPZk9lZ3Nna2tqM3ZLYlFrRDRWd1o0OTMvSzhP?=
 =?utf-8?B?NDFnYm5DTEI1NFUzaGxTYnFLdWZqY0IxZXZ6NEZ2TmY4Qjg0RXlKaUJ3bFlN?=
 =?utf-8?B?RXdpWExJQjBUTDhXNlV3WCtJSHdxc25sQ1N0UGptNitXL25INzc5T2UzclZY?=
 =?utf-8?B?YnkvMjExeGRRcFdQNW80ZVN4cGFaUUJ0WXJhOTVDZkJYb3JXc1N4dFNtcEtR?=
 =?utf-8?B?SFA4TEErRmtLamN6ZTdTTVJpU0hoektjZGtxWUlpeVFqZDVJZ1JvRG1tN2VF?=
 =?utf-8?B?OXFyUU55SEtHWlhEZTZKbFNWdk1Tdk94YThETDlhYU1kL3l6OEJuTFVyQ2xm?=
 =?utf-8?B?eEZZT05GMzJxWWFOa0svQkFHUjhUSktkbFFBYWlMWVhYWk0wNVVYRkRvczVz?=
 =?utf-8?B?QXJWUGlUNUYzeTdXZXloUGEyUWo2Sk5Hb0c1cXNLVTh0NEFmZ1RZMjJ1cDNZ?=
 =?utf-8?B?akNNalplMDdHSXp5NjhhU0p5eDRrTFdhUDJaR2RaSm9VMVJvUkVFSkFQaEh3?=
 =?utf-8?B?TnRtSXZRdGdTSWZKdjIzMXY4Y0EyZ2Z6MWVwT0Y2SXFlbGFJdmRnTnRSTTZI?=
 =?utf-8?B?RlcxelpwalU1aDBiT2lkdHJJVWdlTDU2ZUptRFhPV1dwcjcxMms1T2V0ZGVu?=
 =?utf-8?B?YjEram8xSW1OazYraWEyYkFqVTcrL0xjWnd5RWRTM3VOcXIxZGZRUVhaVjI4?=
 =?utf-8?B?aGR0QlJKUXdJeE1UTTV1eEdVM2dPMFdLSE9LeGVRK0Fnbzc0U1ZpYU5FQWp1?=
 =?utf-8?B?MElQemw4TjlwK1psRTBHQVMyaTF1UkJnS1pNbUd1aHk0RE1taEV6bVYybTJN?=
 =?utf-8?B?QUdkdy9DbzRNWVFzem5vRmVVdzlSemRQM2NwbzdOMUtPblZ6ZGdZdXJPdkxE?=
 =?utf-8?B?NHM3YnprcXB5eUNrbmE3U2RaTVVYcmRFM3ZUYVp0bGxMSlNMN1JVM2I3eXJH?=
 =?utf-8?B?NW10SjJZY0FtVjd3VGVYZENDUitYaE9xUHlwcllqdDZTU0lrYlQ1MVR1SVlE?=
 =?utf-8?B?a1ZPRm9FWEZtcExRazdwWlhBQ3pCcjg3TUE4QjZzV3hlREZsNE55RW9SSG91?=
 =?utf-8?Q?sOhHP3OVgcWXlD/+yrniy9sc0BQxt2r//boBg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VllMYkV4ZEFDNHRGSVpQRVhQeVZncnJIeUZrMlQySFNDWWJNUlFSSjVwL1Zk?=
 =?utf-8?B?SkZlRFh3VzYzSXF4OHRmbUs4WVhMOHN1Z2VjS0ljVmF1dGhzZnNNZXc2dk4y?=
 =?utf-8?B?QllDdCtpTVpyWXZOZVcrMjNxTWZEODRIajI5bVFtZGNzVk5vdzVvMElUNHpZ?=
 =?utf-8?B?Q0FQSXVUL3ZHRXpNNEJiRVN2UjN1T2lHOG9mL1N4Tnl6allXQzB0djZOM2R3?=
 =?utf-8?B?VDllajhpQ3dpaUFVNFRSYklDMk94TU5Ddm5PbkoyRW9DSFNhVzhzRGxQNHpt?=
 =?utf-8?B?MWQrOEQybzMyWnBnbGhPa3dBZGdsSDZpblk0OEFzbkQ2TEpvUjhpb2tiQWhU?=
 =?utf-8?B?N2wzRllxL3FnQjE1ODdFdi81SER4YkZOeS9ROFFic0lXT1dXWmVsRFRUN3py?=
 =?utf-8?B?SzFadW5TRSs5TzJJNG1hUm5Fc0ZBUURYR3BVazlhSmQ4dTQxdDl6NFdaOVZj?=
 =?utf-8?B?dG1jSmthY1RLUTdhdHhDRzN4MFZTTHhyekgxSURyWW5JdkpsbVdFRVJIbmJJ?=
 =?utf-8?B?S3JUSlBqQlFSamZySUVkQWt6ZVI2UXhZeUI3RC9uTk5YQllCakZtSE9lVzQy?=
 =?utf-8?B?UTI0cnZlK0YrZ29SbHI0dER0Q0c2ekJRN1dmVEFabENQYkczSkwwQ1NkYnpF?=
 =?utf-8?B?Z0tac2plQkZRNmp4enl4cFE1dHJ5b3V4bEU4RW9URUVMRnVHemVFWVcvWGZG?=
 =?utf-8?B?N1d6LzVKTGVzVmpPaWpRQVN1RDdQcC9IZS9WQnVFQU1aeTdPNzEwTVBiUWF0?=
 =?utf-8?B?UU04WG9TVFB1VEsxd0ZGWkl5UVRKTWRUQWlCU1A1L3J3Z0ZjVmlHcnpPeEFv?=
 =?utf-8?B?ZDU2d2tYeEdqY2RGWWpwbU0zWW5oR1hpNTlRcEZaOU9yaEl3WFdPSUc3REZp?=
 =?utf-8?B?N2UrWXhDdTByQVgwUy9jeFBSRjhrUEhoTkx3UjJBZU42TElZNmZlSSt6emt6?=
 =?utf-8?B?bTQvblRYWjZIRXhKNWhSY2l3UFV1YWszeXNVZlJ0UExuZ0VRaHFOQk9Rdm0r?=
 =?utf-8?B?Qm8zdHY0T0EzTkcrTFNuSGlmT1FYM2tLcktRWjBuazZSdVRpam1UVktVWVZv?=
 =?utf-8?B?WVpXemc2R0FLK1BsM2poMWJUY3pCanNhYU4wc2ZiRkxSa0p0dk92cEtMLzJP?=
 =?utf-8?B?MlVGdDN1MUpkcHBLajBFNCtIMEpMS2hJU1huL1pHQm1obWtXZWJLWkF2Wi9D?=
 =?utf-8?B?bGNaNHg5SFU2VmZjbXNuWEJreGhjV09ONlhsYmpqcjVvUnBDZDhzdS94d1ht?=
 =?utf-8?B?MlFGOVdXSTE3QWJqSEczQml5eDUxQ25MYW1vQWttaWY0VGU1MU91K2FmVmta?=
 =?utf-8?B?SkllYTZzZU5xR2F4aUtWM0hJdkdKdmhMU3M3Zk9pMHhYaFRIZXc0UzhOVEc3?=
 =?utf-8?B?WVVoRnNRU3lObkFDaWRIa3VVdTRaVHE0em85bUNqUWpMM3cvYkJhY3NWQVZy?=
 =?utf-8?B?L200RDlLck5UL3k5VzlKb2Q4MU04ZzVYVEVMWVAwMTJOTllIaG1iNzVhRDFM?=
 =?utf-8?B?dFFmU2tnbXl4MjZkL2hGSTI2TU1iVndGZjV1eUNReTR0N1RPVks3UXd1bzlr?=
 =?utf-8?B?U1ZVQ20zLzlwaGQ5VDQ2eDBHamlBWWZsMzJJSHQ0R0xwZWllWDhWMisxZjFE?=
 =?utf-8?B?Mm4reVo5NlFtK01HZko2S0FSRVhnV1NMWW02Y2d1ZFBpOVZMTnM3MUk1RE5p?=
 =?utf-8?B?ZTU4ZmorRklkaS9ERFk2UzlkTkZFeHVXMFM2b0ZBY1hSTVFhK1g5Q3dOam9E?=
 =?utf-8?B?d1JvVWlLOTNJMHB6NUtQV1BtUXJ6THZxUnZTemVCRi91Q3FVbTh0YkRLVVU4?=
 =?utf-8?B?VkV3N3ZNWHNQUmxlUGkyaDlGTGU3RmNFU2VvaWtkY3orc093Nis1VTRFSXA4?=
 =?utf-8?B?T3kwZ2RhMnRNSHl0WXdpckVnUUdmMHRoU0xMK3NFNlhQdU9CanJuSWVJMEZq?=
 =?utf-8?B?MkZybkMzckdCN1g4ZCtlTHNzbmFENlhkd2g0OVJXa29Fcnk1S3VZNVB6Umlx?=
 =?utf-8?B?YVk5VmpLZEZKZVpiQU51My9Tc1JuTUtvZGtIUDZWQjNHaUs2K0hpWHltYmda?=
 =?utf-8?B?MmFYdmFJcVJQUTkrYUNXb1ZvbWp3TGlYcG1VRS9qTUFjNlhBUVZ5dTUwU2Er?=
 =?utf-8?B?WnJ5aUpiOS9ZUjBKdjhSTzRtb0ZWQjExd2hWeUl4a0d0blN3S05lTzNKMzFx?=
 =?utf-8?B?ZklxcE5pU1NwZmpPbFVhY1NwWVpEUng5TTc0V2s4d05GZ0x2YVRZcEZPNUVs?=
 =?utf-8?Q?rGbMUzippEtUnzmqkR9qF4rBDqG7hoFisIwmJVE9hM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <823BAD78B6D4ED45AA53C8796679AC56@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c87cdb-900f-4eab-b3b5-08dcf3f6d80e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 06:41:09.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUOJBSIrCYGvkB4sCYB5I9j2j72ABeVaQOwEEs8fe88dW3SDrH6arXlb2dNerCsdFlcFqs2HvY/xcK87huBkTLHhkzTdSKUvZGhRcUd5JBXQ0xGbRssKfZsn7GM7ol0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPFAE0A1427F

VGhlIG1vZHVsbyByZWdpc3RlciBkZWZpbmVzIHRoZSBwZXJpb2Qgb2YgdGhlIGVkZ2UtYWxpZ25l
ZCBQV00gbW9kZQ0KKHdoaWNoIGlzIHRoZSBvbmx5IG1vZGUgaW1wbGVtZW50ZWQpLiBUaGUgcmVm
ZXJlbmNlIG1hbnVhbCBzdGF0ZXM6DQoiVGhlIEVQV00gcGVyaW9kIGlzIGRldGVybWluZWQgYnkg
KE1PRCArIDAwMDFoKSAuLi4iIFNvIHRoZSB2YWx1ZSB0aGF0DQppcyB3cml0dGVuIHRvIHRoZSBN
T0QgcmVnaXN0ZXIgbXVzdCB0aGVyZWZvcmUgYmUgb25lIGxlc3MgdGhhbiB0aGUNCmNhbGN1bGF0
ZWQgcGVyaW9kIGxlbmd0aC4NCkEgY29ycmVjdCBNT0RVTE8gdmFsdWUgaXMgcGFydGljdWxhcmx5
IHJlbGV2YW50IGlmIHRoZSBQV00gaGFzIHRvIG91dHB1dA0KYSBoaWdoIGZyZXF1ZW5jeSBkdWUg
dG8gYSBsb3cgcGVyaW9kIHZhbHVlLg0KDQpGaXhlczogNzM4YTFjZmVjMmVkICgicHdtOiBBZGQg
aS5NWCBUUE0gUFdNIGRyaXZlciBzdXBwb3J0IikNCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQoNClNpZ25lZC1vZmYtYnk6IEVyaWsgU2NodW1hY2hlciA8ZXJpay5zY2h1bWFjaGVyQGlyaXMt
c2Vuc2luZy5jb20+DQotLS0NCnYyOg0KIC0gQWRkIEZpeGVzOiBhbmQgQ2M6IHRhZ3MNCg0KIGRy
aXZlcnMvcHdtL3B3bS1pbXgtdHBtLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20taW14
LXRwbS5jIGIvZHJpdmVycy9wd20vcHdtLWlteC10cG0uYw0KaW5kZXggOTZlYTM0Mzg1NmYwLi5h
MDViNjZmZmUyMDggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3B3bS9wd20taW14LXRwbS5jDQorKysg
Yi9kcml2ZXJzL3B3bS9wd20taW14LXRwbS5jDQpAQCAtMTA2LDcgKzEwNiw3IEBAIHN0YXRpYyBp
bnQgcHdtX2lteF90cG1fcm91bmRfc3RhdGUoc3RydWN0IHB3bV9jaGlwICpjaGlwLA0KIAlwLT5w
cmVzY2FsZSA9IHByZXNjYWxlOw0KIA0KIAlwZXJpb2RfY291bnQgPSAoY2xvY2tfdW5pdCArICgo
MSA8PCBwcmVzY2FsZSkgPj4gMSkpID4+IHByZXNjYWxlOw0KLQlwLT5tb2QgPSBwZXJpb2RfY291
bnQ7DQorCXAtPm1vZCA9IHBlcmlvZF9jb3VudCAtIDE7DQogDQogCS8qIGNhbGN1bGF0ZSByZWFs
IHBlcmlvZCBIVyBjYW4gc3VwcG9ydCAqLw0KIAl0bXAgPSAodTY0KXBlcmlvZF9jb3VudCA8PCBw
cmVzY2FsZTsNCi0tIA0KMi40Ny4wDQoNCg==

