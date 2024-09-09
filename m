Return-Path: <linux-pwm+bounces-3167-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D127D971593
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 12:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC91B20BF9
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492621B3F1A;
	Mon,  9 Sep 2024 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="wnFbh1xa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F442AAB;
	Mon,  9 Sep 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878644; cv=fail; b=Mn5FCpCN1I/I/xY+1gWk85J3hozR5sGBNOBj+sCpY04eTZN+YR/s+bY7DibMu372xVPByWFwcZxOas3qy8URfpzJ0eQiRqyFa5bjyZ3m2sf++5h+Yp/PWQW+ilt5fs9nmQMf7uab8i4Wfnz9sEAlfESA0w8Mxo5PxOt0bSkwNLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878644; c=relaxed/simple;
	bh=yQH/x9QAENPcIhroAq24u3wo1CJ3NS9VmyDFhi2IhbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V1X9O1O3WMmhjku9N07aWXNzEqII/J56zwwDuSkZcFMbtoGqZrGBwMtU9URoPbSae14KozWvK3KruYQBywuMJifmO7Gpjfkbfa9MxHs8+UJQ5JYp7CzAmr8I93JAQTknjpgh7kvEkU5NIylwrQ4ide4BtCdvxceN3k9AJbVaIbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=wnFbh1xa; arc=fail smtp.client-ip=40.107.215.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u52fGOHKwzfKpKIegIF54V6lEAt/NNfO8niv8b5fhjQUwX/nTxy3eMPYF26AVDWANFNlglvf5dVNoujTfWEYmIanB71J+gFrfeknBlD+HnP9x8/pdIHuASn0hE+UootQ53guCXNcdbSYT2xrv7Dg4d5I0j+iTbnfHMsEY9fLWu2q+4oo6Hu78sH9DXB2WnoehbWrp9euibCIrCYAld1LQxoJREg5dtQvZU8vK10fxLFODChKEDO2mWLPS07HWDF+1x3gnySY8TGR3Q6Y8FldCVtAhh3cO6hBI/W7mSnbJXI/tNOUvK3efyZDnTa2SdnNFyvNQ4lfomRDfOyTlieXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cqh0GqdMeIVEf1aeXqSG+i4OBRKfWYrDGlyJ61cnqIo=;
 b=DfM6FsYUZ+W6fzIoVKEgM1qN8UNH8uzfgxqyk5UYCZisVh63pcyXWT/mv1NUtOkV8sK4H4cS5nS4D1a1RLIpvU7qJdh1L1NNg6BFO0MmVmWNDc2xJbOIRR4H/6iblfC14Pgu8F+f+StER0bJJzkif9dorXVDqVpHIEzQphDUy/0arSfBZXk/eOA3FLLvhEVvf2+dfH7g2HRLKRRWlLCHWIs1q3fYu9O2XqxD3qS9WiSVbRA9fGrVbv9/9h3GSSnlir5seBHbXtxdjf7P3N3/htchUZiQmbdXKmsvk7/uG0GwQKPtcwInc/MqkfHpYs3C8oL02vWwg5iDdoraw+NAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cqh0GqdMeIVEf1aeXqSG+i4OBRKfWYrDGlyJ61cnqIo=;
 b=wnFbh1xahHMQbpaBZ49ZiBEzAEKfk/4Dzg2quIB71PsYDwkMU/kCw83VcB6nceOr4mIMeOG4miNOM4TH1xUP0wNr05F0wt8Tqa2LnuHWdV9B0kCSHlo5IF+T5s/APOp8CsYi9/57ImtWaUfWy58cz9+OQWC7ElUdCj37YuvKPJhNqo/fzTaF5tqJ1s4UGOwqQY9gBBh+f3DrVw+7cJPDl0/NU67qec+Pr6PFNjmvEYd82gm/Pf5y1Wn8hvyOql945ExHs9gl2vsyVb1yzi72BjGKlDafZOxLqaSOV6Ke1zETDqfYUlcc4krIaFsV3EXNwaxR8l3K2ir1au7L2B4uYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by PUZPR03MB6854.apcprd03.prod.outlook.com (2603:1096:301:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 10:43:57 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732%5]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 10:43:56 +0000
Message-ID: <74af2432-2c71-4fa9-8a00-1c2f3c49033a@amlogic.com>
Date: Mon, 9 Sep 2024 18:43:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: amlogic: Document C3 PWM
To: Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20240906-c3-pwm-v1-0-acaf17fad247@amlogic.com>
 <20240906-c3-pwm-v1-1-acaf17fad247@amlogic.com>
 <8e25bd34-723b-4339-a9bf-895f42b6a8d3@kernel.org>
Content-Language: en-US
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <8e25bd34-723b-4339-a9bf-895f42b6a8d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0252.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::10) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|PUZPR03MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ad14b6-3bb2-45d0-2160-08dcd0bc4e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkhUSUJFcGNOYmpOZnU2Y09VNHNHN2czM3hxL0Q2RzVCY1NIdXowY3ZVZU95?=
 =?utf-8?B?RGFwR0ZnSnpJdkVQOXdKemRNc01hZmlzZ0MwOUY4NDZxMnE0ZVl5c283aTlX?=
 =?utf-8?B?c2xQdVNXZklYUmZnL0dmNmtidm05cjN6V0J0STQ3M2xxaEJRK1JjSGg0Q3Rw?=
 =?utf-8?B?cTNGeUlucXNwODNUcFFFdnFXZXpZWXEwUjJoc05mMm5lMmpwZXFUcFovcVdi?=
 =?utf-8?B?SEovR0ZneWtRMlp3R1luLzNxN3pNQ2tPMDVSbjlNeXdPQ1lnaW9iRDBZTnd5?=
 =?utf-8?B?NnMwamhYMFUwOGJzckJWMXFWT0hTR2tsNlhOOHQzMU9wUUpwMTVSb1ppQ01D?=
 =?utf-8?B?cVB1UTZEa3RFODRpVXVuZ1F4TzJlL2xZRHNITkpVS2dGUGlJaGhKaUpPeUVv?=
 =?utf-8?B?MDRvQmFtZzZtTmp0Z0psNnRXWG91ei9wNGt1YlZrRHV3cDhxZFZuV29UM0Fs?=
 =?utf-8?B?Vi9lSGlwUStmcXEySWV0VDVXdis1aTQ5MEdpZk9aL2ZuNkE2ZnkxSFFvbWxv?=
 =?utf-8?B?WHd4QURzY3Zzd0lqTWU4KzBrZU55cWt2UnhrMmNGZ3UwWmw5ZXMvQWJmSUg5?=
 =?utf-8?B?aGpVSTNCVFVFeFdHajZlVENSN3k2NHNHM2VQVmR6aVZMTUxsR04rSWhxem12?=
 =?utf-8?B?em40bFVDdjBWUDRqZWpRUzVyUTJhakVWZXhlVklHUUF5bndNTVRwQ24rcDU2?=
 =?utf-8?B?WmVMU0N5bUV0QkFmV0xHTXBLT0ZqWWV1WVMxaUwzek9DbEdwMWU5SFRHSGhS?=
 =?utf-8?B?WTRITGZ5ZUcwbnowcEc1bTZvb0p0S3hMcjIwTS84MTV0QTBrNWZGZE1Hd2p5?=
 =?utf-8?B?a3FSMGppRkhMOFN2YmM2R1BaYXZMOFREVkFicHA1MlhGNUUzWWxhUG9YdGNm?=
 =?utf-8?B?cEFFREhXc2ZBbFJnbDl1SkNYNnV3TG1Ic2VuZ2hGQi81a09RdC8rekVhSnUr?=
 =?utf-8?B?SlY1TTg5dHZjT1hPYy9yd2crNkphWm91d1QrYWJSOE8ybmZxRGFaalFMRFBx?=
 =?utf-8?B?cm4vMkFxWndRYXRscks2V29oU0JiQmJ2MWNZUmVTZkZ6ZGNXbU9KNk9VMmxG?=
 =?utf-8?B?dzdWRjFsQmIxSkJONVNBaGpRMzRXbGp4M0N2cEsvc2Jtc1d1bkxMZGZJb25m?=
 =?utf-8?B?clF1TlFmNlJkN3hudSttZWFpa3ZQbnFtc0RwVHVVZ2hCeGlKS2hRTWpyYUQy?=
 =?utf-8?B?WkI0R3hNQkh4YnpTLzRQOUtzcytWbnhCcDNObDJxZUFjNE9HelAyTFQzSUF4?=
 =?utf-8?B?bmh2TjhrRWxPUXZ1WmZxLzltRDVtMUFwdEg5Qk50aWRWUmlONGtWQzVZMDc5?=
 =?utf-8?B?TWx6Q2F3T3RnNjVPRTMzT3FmS3hVRGZ5dTYwM3hUVTZkcGswU3dFVlNHSzZX?=
 =?utf-8?B?N1F5S0tjcDNoVU45ekZ6RVR1MmpQUmVqaC9CSloyTVU4Tzd4U1Nac09qY0pQ?=
 =?utf-8?B?cTJIa090ODE2K0lmS2JMaXBVd0dTSVNZYlc2ZEx6SGNnT0Zzb2dhNGoycHYv?=
 =?utf-8?B?eHZpMXpuM3lxMU0ySUkyekwybkZHMnpkQjAwam0wQTFQVFFJekg1TzRFSlU1?=
 =?utf-8?B?aFlvck9ndm1JMGNqRXBYS00rdW9LV0xUQXpXR2ZGSElQY3NiYTV5UHJ6UTFl?=
 =?utf-8?B?NGRCUnZCMElJdTFmaFJuUUF2a2pBT0N4bnZ6V3I0Zjh1S3Ewb1hDamcxelRn?=
 =?utf-8?B?SlRCckpQcXNlSTJOWTM0bE1TQmlCcTVTelFacjFoT1FUc2JPWHFvamVNM3dF?=
 =?utf-8?B?TWtoK2VQdG85U3dIUWhqUnVRRWpIOUlrZ0tVTWxYOWpYWmJnQW5DNWlVOXJK?=
 =?utf-8?B?N2w0MFAzbVE1VVdWaUtIQTROM0owMkdzS05ua1M3dklMeTNabWl5QWlkV0c3?=
 =?utf-8?Q?iGi1rif18MhiS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEh3Q0F4dnN6NEQwUHFmSnExZktQUHpRZGxoUmFKSnV1enM0QVhwYW5nbzA1?=
 =?utf-8?B?VFoyTWZRZTVabnV0S09zMTN4bDJ4RVp4bW0xRXZIRWJHdjR3N3dKYnRiSTJa?=
 =?utf-8?B?UHpnQ2lkRW1ybXFaVVNGNXo1UkFCbWVhbFVYd09xTEZnY1grbmgrYTdIQWNL?=
 =?utf-8?B?TEJwYXB6YU1rZktoNCsrK3VzUkpyZ2xJL1JocXRlTFRNMk8rVDJ6R0k2RWVN?=
 =?utf-8?B?OWYvRE9nNnhyaUM4bHZNd0hsQlRHR0p6cHBvb251MUNZWU9sZUdnTnU3UEhi?=
 =?utf-8?B?UkpUazJMSWRISkJTQldDdTZqdFhJQWdaZmMyY0NCZ3FjR3FVeFE4b1FlWita?=
 =?utf-8?B?MVpFMUtObTdrNUg1ZmFScm9nWHRlNUo5KzNjL1BMSkpVZUxKNDQyS3BmN0Iy?=
 =?utf-8?B?bVg0YXRpQ2gyNmpxV1U2VEFuZEhJZTlKaW1JN2UvN0JFS2VNWUlDVDZSMmRR?=
 =?utf-8?B?MUtISjgvYTdUMTd6aDRna0hmMU9sVUx1aFFqems0Zy8zRXlqdUlTUE1JN3pq?=
 =?utf-8?B?VVhQVnpjeUZDeEpWa01hUWJyUStYZXc4WE9hL3pHSUFueVNJSVVCdFg0WDg3?=
 =?utf-8?B?ZHFmNkpENE92Z1dHeGo3SmZCNVEza2RHM3Vqam1FMU9LZ1M1OVByL3ByRCtj?=
 =?utf-8?B?K1A3c1pDKzBGdXBIQXhmZHJlQkpRaW1lZmNKMjBuMElVZ2pkYUN6ZVJMQzQ1?=
 =?utf-8?B?SGxSY2wzZ3grbW5zY1hSS0xyT21FdlEwR1N4a0hMQ2lqNkJGRFR4WW0vZDht?=
 =?utf-8?B?VnAvMW5tM01VbURVZy9vaytKbzVRa3NmQ1ZzN0owL0puNURXSllhbTR1Y093?=
 =?utf-8?B?MThuajJRNWZXUklFYkRUOXVtWVN1V2oweXVBSStoamg5eU4yRUZnd3M1Snpp?=
 =?utf-8?B?dmh4Sk1ubEhkSW05cnFpcmgvYjRPVDhSb2FiMVZrUloxUUVmdS9seDIvWm5I?=
 =?utf-8?B?RWVyY2UrMnNZc0Y4SzF6NTdIWHpQZy9YSWNlTThIVHlYRGFLWGx1Z2RQc1Rh?=
 =?utf-8?B?ajlxNHhIWFZMa3dJNkVGVkZWcFJzUVJRK0FQampsQXBoc1pSUVRUT00vZTZo?=
 =?utf-8?B?TnZjSXg1S1d2YytZQ2YycGpmVDVQUGtKaFBMdExPL0VjdHh6K3VlM0hJL0tS?=
 =?utf-8?B?aHJOck5FZldKUG5kaWVja2dZUldTOWc5OFhiWkRRN0czTnU2RXE5NmtlVHdr?=
 =?utf-8?B?eFBrbmg0YWljVWNFS2plRDZiZnU5VXJtd3hjZHlTMTZ3M0ZRZFBkdXJUbXdv?=
 =?utf-8?B?Q0hRRWo2M1JtRzhrZEhhekU0MGo5SU9LZVZFbFh1S1pJcmU5SVMzN2duVXdl?=
 =?utf-8?B?RU9SY0lUeG1ab0tLZ2pxa3M4R0VZT2RJT3Y4cVgzcVFDaHdTMjl4WE41TlE5?=
 =?utf-8?B?dnZ0T3krcFdMWkFBSlV1Umh1cWlEMlRQdC9JMnNWVkdhbnlIVnZuS2hjUFZW?=
 =?utf-8?B?NVh6MjlSZWpNWmp5b2V4K2FkcHVGVE5DVFd6UElLaGFnL3VHSzkzQS9DZHdo?=
 =?utf-8?B?K0dqdy9iOEtNWHFvOW9SVHk1NDNMZHhuNUwwRnAwRmxLYUFGdHg4MjdUalM3?=
 =?utf-8?B?L1N2ZmNKUk1VbzYvbm1yZms0c2QrZTIxSFZQR2RiN0R3bWNkd3NRbStmWFRs?=
 =?utf-8?B?S2FaTGFMa0NpSzYwcVB3Q0dWOXY4QmVOV1RUQ0s4aEVmSUNSUCtBNEovd3VI?=
 =?utf-8?B?WUs2cXJNdmwyQmF5TmlML1QzT2lnRk5HSjFaaGJCZjRySmREYW9EazVVbkRw?=
 =?utf-8?B?VFpTRDZwdWJWeldvTWV6MWZsUXhQcHMremwweTEyQTBHakhFNXNOR25OWjVl?=
 =?utf-8?B?SVNYUGpQVDEzTFA2WSs2TkxxUmt3TGRrZVNiWHhuT0VQcjNpRDN5eitqK1pC?=
 =?utf-8?B?TVRBUGtBZEttck4xTThrS01kVkx5UkdpYjEwTzlhdUFIc1lOcDhOaUVvc09L?=
 =?utf-8?B?MzdSRXcwMTE4eHZKenFNcFZsSHBwT1Roak43UjNXTUVrRU83VEZjWmMyQWwz?=
 =?utf-8?B?Z0hQU3B0SnBsWFZia1oxc25tN29VaWNlbDJwUUtmR3ZjSTNxaTZJWjBiSkky?=
 =?utf-8?B?dWlxVzdGN1J2blVLdWlNRjUwN0FYa0ZrUDl4YjBPZVNITmpJTWhoaXZ3bjVH?=
 =?utf-8?B?cElmMWIzV3IrK2lvaHBwMlV3SklSUHhqUXdmQkFyTjVadnc5THlwcHlIQjNk?=
 =?utf-8?Q?hgoRRlCd2C6Jq4Wy5NHeTv9PHixGVhflseYB0wGY/IRF?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ad14b6-3bb2-45d0-2160-08dcd0bc4e1c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:43:56.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxM2fSlosIpAWJyERIHkAiUfUqplIfULp5tE9NDCLwKrnUYxY3Q5ZOzks3BVixH3NpQFKz05aq+gzPeekNHvi/CUuaoh3Cr9+6Poq0RNSCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6854



On 2024/9/6 20:50, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 06/09/2024 14:46, Kelvin Zhang via B4 Relay wrote:
>> From: Kelvin Zhang <kelvin.zhang@amlogic.com>
>>
>> Document amlogic,c3-pwm compatible, which falls back to the meson-s4-pwm
>> group.
>>
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index 1d71d4f8f328..356371164acd 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> @@ -44,6 +44,10 @@ properties:
>>                 - amlogic,meson-axg-pwm-v2
>>                 - amlogic,meson-g12-pwm-v2
>>             - const: amlogic,meson8-pwm-v2
>> +      - items:
>> +          - enum:
>> +              - amlogic,c3-pwm
> 
> Assuming that lack of meson fits all other instances of c3:
> 
That's right. C3 does not belong to the meson series.
Thanks for your review!

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 


