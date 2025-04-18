Return-Path: <linux-pwm+bounces-5569-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B9FA93929
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 17:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 208737B103D
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698BC204C0C;
	Fri, 18 Apr 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QhgvEekO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ssBbxkUp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5C1D54FA;
	Fri, 18 Apr 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989101; cv=fail; b=FzOzuohg5BKCU+ic0QI86QkGXwUo9U1GVpSjhpkJEE79ie4e/clFonvcVRl2Pa28QYKfuPKNNjm3xQ3Y8MmoD5eyeoo7e+g2sUn+fyt1pNn3FToRvM7Ff6jmgG0YRq8fRc32oa+KniS7A6zZ2hCJN/bVIFl3hSM34sS1Hvub2xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989101; c=relaxed/simple;
	bh=ocWHpUFkusW+AWFajHe+VLRonnLo/MzFyGBluwx09+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cCaJvN10JT+oO6tyZ0FMC6DLomkb31hCJIeL7rFN280vYVNh+jst6K27ukPGJ9tpb0y74yZPwbzpmHsWXlRVaI5nnn8eVWi/ClXLKfyYCaTGNgiURpgCxDtxrarnVIoxm8TBUf7lTm0j+1FZ3KR8CozLvsKCy/tB8iWjSlkiFf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QhgvEekO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ssBbxkUp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IEA2bA023778;
	Fri, 18 Apr 2025 15:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=orIuvXKWjw3CzIySpoZSqQLub5YYxYEpTVVCIyP0PV4=; b=
	QhgvEekOZItjtOe0vR+UymPz0NGgSGmAaUFPCScLgQmHUDEiZzJn9TS2UtY1svqQ
	5t7y/s1O8TGIkKiZkih1+UEpFNt0+46aDjYyvETcJAqVndIVJS7ictBpVhiox9nP
	5q9CClgzIHvr5iPUuBLlzvMBevkJH/2NN8PeuHvlaq5ZeCbK47Rhiv9oCWHo2ZGh
	hZF6WXsrkr/Pv9EyJE+7Ljlf3iW/ATrUkzVCOEcaulrzG88orwoqddzOv/rqpML0
	a1VvJEzhdpkKzlMxM366h7c0WBkPBvzssOUmiuZuPZZr6RGt66LqZQplkm34M0o4
	NEbo9AUNpjUgDbunAPCLuQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd8agg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 15:11:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53IDtwv7030959;
	Fri, 18 Apr 2025 15:11:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbf8sch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 15:11:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGo5R/XWbxI5Hn6cOfkmUQoIySsWts3fzMJ1vIf4mLIKf5pCf9GBv3OiHcxmFtmkrsAOb42RG1Xi+d4bZetF9zy08io8UmTZTk/fjdRsGQiPKiQ3j9dZWAZypwPCkuD0rVq1c0fq6eFPFHOu3MVIGpY4gXNPVvAnJL7ilVKBSMZU1saR8Af5jfcLK2UM2/6vr9o1baRZ/090SwnuV21FcqShAYX0yAnsd1nwLP/JrFCvLSDYBLImtgl1M3qa1Y1ShBupIL34SkJebwvTSaloHAfOIoQsfknMdKEqDLYlOnJaB7QjCgklXvHvU7QBvFR2K8fzxEdrGDp7Bs0oA5yCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orIuvXKWjw3CzIySpoZSqQLub5YYxYEpTVVCIyP0PV4=;
 b=OQ9UMuvuaeUDcn5LGCLQSySHkdsHY6jj60iKc+eKVx1Be+8Vz6jg7Ec3JnGaQZxu0GIt5wKAq28h5hbnZKlC0jg/tgHo8AwezNZMGH6p0ZqdNWU/ptstkWuqki03Cu5zAfW8VY+AREbLNysoHj1M/qD6taRTxsoXqf/AgWOk4sRHqedCSCFTPW1vBrLTeCyOw8DwXr9BMrZvvgMFbl8KQZu8ZKmuV9S23x3xDIlCU9JIZoUKAkcCcSnR7hUYbXC3KDD4mqfGEIXMFugfY8vFg0W3am4bh8hk72ucaLCjMIWef4kQyZn9GMX33QkpjVLxGHhNfk3Etq7RjEUAvT2HXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orIuvXKWjw3CzIySpoZSqQLub5YYxYEpTVVCIyP0PV4=;
 b=ssBbxkUpd53afREmCTJiUGRYhE65lrFeLSdFqVEJoLTOWRCdra6iqbovNNRh0ZB2wYSS5reW8pvtmJ5Ny9KbK+TyYQnyXffUQTWNxC4yXuV3npTlRf5tV4bHacwUhmVZ9UvrHq15F5iEwlvS3Sx3fHfNzVQ0Ktha0SukGt2Yigo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 15:11:11 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 15:11:11 +0000
Message-ID: <a0d63c0d-7f17-459a-9ba1-6532a986c8db@oracle.com>
Date: Fri, 18 Apr 2025 20:41:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v2 3/3] pwm: sophgo: add driver for SG2044
To: Longbin Li <looong.bin@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Paul Walmsley
 <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20250418022948.22853-1-looong.bin@gmail.com>
 <20250418022948.22853-4-looong.bin@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250418022948.22853-4-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH0PR10MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a4e9da-24c9-4c08-eb8c-08dd7e8b410b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1Bla05yNmVnNmF0U2g0UkVaYU94UVZjdmIxUjY1SEtpT2ZiUmtmaVFrcFFZ?=
 =?utf-8?B?N3hCWkl2VGU5d2d6czJSQTFzcUNlTEFPdjJZU0JGNmpIb3ZTSDNvRlc2V04x?=
 =?utf-8?B?OXB2QUVsUy90NStWQWZjODQ0d2lxZDRoZ1g2S3pGdFZrajNtUFZHcFdqYTNL?=
 =?utf-8?B?UUpmMlZ0WGE5Z3drejh0djgzSTJjaG5rSy9QVXk5WEllUzVUdkZqZFIxOGNk?=
 =?utf-8?B?U0lWVzZYVEMvTTkxeDVQRWNUMENwclRUZ0M4Qmp4b2xBYVFOVjVidUxueFpQ?=
 =?utf-8?B?d0JTY0NEK3ZZdUdwaXZDS3hGR1AraEpkTGtMM2JHZkQ3TGwxYjNuUXdBb0Fm?=
 =?utf-8?B?TGxHN1RzZy9RVW5GbTBNTFgwcG9WWnk3N1ZHQUlpUGh2dHBPckZaaU5tSVpp?=
 =?utf-8?B?VmlOZktMbks5NGQxU1J6dXMvdkZZWlF6dVB2QUNkNUk5aFg2cmk3aHpYZXNm?=
 =?utf-8?B?cmg1QVp3WW0vclFKZ1BidzVFeWs0OWwrWlBybExYaW5VUlZJWmRycyt5YlNO?=
 =?utf-8?B?RXBMVWdTcUdFb3NXS21HT1ZTRDBwNUZtSjJjSkxBUHhEZTFMc28vOE95MFha?=
 =?utf-8?B?clZhbWduSTF3bnN5YzZ2bGRzZUxGcFFlUWxXZnZlZjU3ZXhDM0xtMzdZZ2hy?=
 =?utf-8?B?Rk1jcVo3TDdEQWdNVDFTc09sb2xod2NrWXFrOVBxY0NJOUJwek1Kamt0UERS?=
 =?utf-8?B?ZGRSZVkwWkVpKzFiWGRWV1p1N1NLYVhRZldGNlNQWUVBbFBXMnZEZElZSnNZ?=
 =?utf-8?B?TDdoOWV3ellsLzhXQWh0Y050amdMMXBMeDdBUzUyNDlvMG1PaEN4OGVNcGt2?=
 =?utf-8?B?VGNDY2srUU9iemZLbjlJTEY3enhXM2ZHUkc2dUFPK2ZNYkc0NDFKTldtZC9V?=
 =?utf-8?B?czliL0MvL1FvOTZPZXVZMzVBSy9xSG45eDdDY29Va1M4Yml4Sm5qTkJ6Z0xr?=
 =?utf-8?B?YjBLeTNCRDNiQ2tPR1F1dksrbjNRM3JtOFpVa0FQNXZuSzNIakdqZDc0VmVp?=
 =?utf-8?B?SjNSK0xxZGtyb3M3azUyR0RmSzN3NlRUN2EyVHV3R2IyQ09NMmhwc05qOG9F?=
 =?utf-8?B?WUNQaDhQOVIvMkc1Ujd0djZNaXRpdkNONU1ORjlCUndjTExUZTVISllJTmk1?=
 =?utf-8?B?Yk80ZWJlWVdqV05RZjRmZllZcW1mRzllMXNCM0psRkFjRC8rUEt5S1pmOG82?=
 =?utf-8?B?R3RTanpOWW5JK09CYU90S3c2UXQzaUJqcU5EL2JBZkgrRzB1RmFCUllYQTlY?=
 =?utf-8?B?ZUVCeStaaGlRMmRSREJmUDhGdFNWZ25PV0p5cmJvN0xxckR6R3JEOUJJYWMy?=
 =?utf-8?B?Yk1PemorVGpTZlpkekczcG1MQ2xXMURVOThaWElwZks4NWgydTBOOE9jdHcw?=
 =?utf-8?B?K2ZDN0p4Zyt3Q1JKM1UydS94Um53b1hmV1I4amVwNUJ0K1BkQWpCSUJpajlk?=
 =?utf-8?B?dS9uUGZKQlhGVndac1IvNDVGYjF5dE4vOVZlcjBIbHVKYVo4YlNVVHRwYXBU?=
 =?utf-8?B?TzhFWHIxUjl0d25pM0pYc2lkaWtqZzhnV211MDQwU0tlSDZjSDdYdkJKTDNx?=
 =?utf-8?B?ZmhFTnBFeUFPNkMvWmdhcS9XZVYzSEZLM1JadUdWbzVZamhZaURySlhuR3BE?=
 =?utf-8?B?TXk2bWxsRzN2SG9JWGhuSUVMRExmZGNWbFpLNWpMaTduZDJxd0RGR3pCclo2?=
 =?utf-8?B?TkJQSHl5eXZsWnRUeHpuMUNJZGVXemVwYjNqdGY5Q1ZJbmNhbFR5RlRUVkdH?=
 =?utf-8?B?N0JCV21KbnhIUmpOVVhrc3U4eGtWZVUyN2xEaGcyMExtOEJKVU84b05HclVG?=
 =?utf-8?B?cUFaNVpDOWcrMkZwRm94TVVPbThnUGxBbmJ4NzVFRHAyKy9KMkFRVEd3NU9k?=
 =?utf-8?B?UzhkOE9NeFAwWjFNK1ZVb01OMk53WnJjelY4eGtNcEdpSEpUWnhtOEdTVDA5?=
 =?utf-8?B?UG54WHh6U0hvOFo4TWZuMXRPa3pmNHlSOGYzV3JPVTd5UzJuRmorTG1WYzZK?=
 =?utf-8?B?clFaR052ZEdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXFKNDlrcExNSEJheUM0d1FkK2dUdGo0ZkZoM1VVWE0xOXlybzdkR1p4UDlF?=
 =?utf-8?B?M2NGQ20vT3dtVzU2VkE5SUVnWUlyakNPVlBvYjBQSEw2OVgwZHo5MFBiYTBw?=
 =?utf-8?B?NEZhcnNvYkt5Y0ZYUlRaOVlMSWVTOFdYNWZEMWxCcG5XLy9TK29GK0JEUmU4?=
 =?utf-8?B?SVdxblVPU3MyclZKYkU4V1I3WmFyWkZUR0FSSHdkWlF4cVhPcThzUjQyWEFD?=
 =?utf-8?B?VDdFMWNHLytPeXJaZ3pkbGdwV25Ya0VSR2JvWDJrQnUxTmg3Zm91L0I3VTVv?=
 =?utf-8?B?MUQwSmVuaW5Mdys4Myt1MzFLaWlWS0N6TDgvQXhCM2ZFbFMrakVDMzVINjhj?=
 =?utf-8?B?VURUQnVwTVRjdFpaVXV5ZmlUSzFkbFZid2dCZEVaMTVXb3pjQ0RTblBFbDN1?=
 =?utf-8?B?eGxROU92U3B3ZGxxYTN1OXlabTU3YlU1amdhOVI1NlJkSzhhTnNEeUhxc05Q?=
 =?utf-8?B?RkNuckdKSkF4S1d2ZFZUQTJKNVlUY1lhdXluVk5sZ0cyZWRySWtlSi9ZV0sv?=
 =?utf-8?B?YjJEUHhpa2dCSnZKZjdEcHpDUmNqdlliRDl2dGx6blFHVG81TEN2cWQvek0v?=
 =?utf-8?B?d000OUxWRXZxblgzY1VxK1E4MVJHT1NoNzJYUXAvVlVoRVlZY0hDajNrdmhN?=
 =?utf-8?B?Y0ZHQmhLZHN5RHRwRE9RY052Rmxrc2prSGczMzhIVTFrRVV3Qyt1RnNzZGVI?=
 =?utf-8?B?SUVuT0Q3dVVXMlhSRzZ5d0xzcDNHUm5qeDJhWFk2SXZZSTJyRkUza0VBbmJh?=
 =?utf-8?B?RDc3bnhjcDB2ZzJrSzIyV0llc2o2d0RVeFdFMXFBUmp5VkxiL01qQnJKNEpi?=
 =?utf-8?B?cnZyYUF3Z2JqTUVxK2VPTXZQL1Jkam5WSmlJU2dwK25jWGlNeVRMNEEyS0J2?=
 =?utf-8?B?cE1xQ2U2QURKaDRsdldPbG9wWUc1aGJsU2xOZDRBSWhZQ2xseXYyMXhEczlI?=
 =?utf-8?B?czloN0I4VnJ5eWVGV2taVm5iYnZvUWwxUW45ejBxU1Y3K0lNWnBoVEN4alhY?=
 =?utf-8?B?blUwVWpJajhEdDdJMENmZnkwSWhNRzZWUDdFb0hKbU5EUjJvdmZFNWFLa28v?=
 =?utf-8?B?eUtpRWRObUdNeTU1ZEVEWVB3VVhkOW4rNGppdUtmaWFWL1I2Q2s3ekdUVnVt?=
 =?utf-8?B?NDEzalM3a1Z3ZVU0eklacitWVWJKTTlVOXJQS0ttb2Q5RHJBQ2JaL0NycG9W?=
 =?utf-8?B?THE3QVlBdTBjdDVUaGZiUHhPQXJOT3h1dGtuRGFHd09hWTBWOGpaNlZ0K0tE?=
 =?utf-8?B?ZWUvL0xkeENUS0VmVVhTQ0FBdy9obUx2RVFQaDlsVWllcFlvellZLzdiTW1X?=
 =?utf-8?B?QVhzK3lhQWpLdjZLWk9FcE9CYmNMQ0Rtb053WFhhTmZrVjIwRFpQandoNDNu?=
 =?utf-8?B?ZFJtQlE5bzlSSllQd2hlem1WZE9HQUNiQ2crdncxS2h4Y3V5R1E3ajlOcm45?=
 =?utf-8?B?S0pOTmw5UTE1ajlsYjFNVGpjeTVSMklQMk1mdkZBMTg4cGM4RG96bG1WNW1M?=
 =?utf-8?B?d2taWGZBWFR3VEJVaVcvRU9ReVhoNWhzc3pMMmx1TjVuSlZVUlBzV1l0VVlK?=
 =?utf-8?B?SUJMVktnQXdjemZZemFhZXV1V29mcGc4U0lpYmc5NnNUOGZmU2tqVjk0eUor?=
 =?utf-8?B?dFA2TkhWMTU0L1VuVGIvdmtQbGw3b0tiYXVqZ2h3MGI1ZFVXWWxaVDhNSzhm?=
 =?utf-8?B?V0tVaS9IL2FEMHBZR1lMK3A0cVAwQTFFSVdlVkRKeTljOVhPRnE5MGRDOVZa?=
 =?utf-8?B?YUMrVVYxL2lVTE8vS3FtOHhXKzlQTkNmaTlSM25jVFo0VzNvNzNuRzJXaXdl?=
 =?utf-8?B?djZ2bTA5SjJqQy9rMHhtSHoxTkZQUDYrN3lzdHVLSVNmVWswNno0b2NOZlBF?=
 =?utf-8?B?MkttRlZmUS82elVZMUlRTFBBY0VlakJ0cGY2NmZaNkRDVnIvcDhiMDh0bUFU?=
 =?utf-8?B?dStBZ0U3K1BsalBYbU1JY2p3ZXFXSmJpdmR6MlZVQS9LMmJ3c0RNeUt3RHVq?=
 =?utf-8?B?ZEpTMTg4UVl3b1QvSUZzcmw2aTdlTFg5R0xXN0lhb251WURxOUdLWVpVSGNV?=
 =?utf-8?B?MjBSb25hSktkczNmVHByMTJ0c1EyR2dWMk9BWTliZzhQV2M1K1dzdjhYclFT?=
 =?utf-8?B?U1MxekVsTzRsa0NQT2o0VzdwOCtOV0c4ZzhrSjlWak1wL2VWdHlCUWRFT3NQ?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PADVByy/jMYGY7sxR2d03I0mUZMfA+wGDRf5inOuD5C8aSD/WRFiqM5wQEGbKS2fakTPP/+UinB5QXesK9w6OahUrhEvk7N45ysUon0LH+pH1pL29Js9UWbFo9Dpekqiej/GXynEkB/+fEiMXUfAoSCROYQQQ/02aNGOHkJLOSWH8m9WzYWaHieLq+zv7dYE6exV888I5MJGHaYmdyHooVSI5DuzjMEuPjhhRxnkdT2C2JItisv18n3do+I/TfpAnFzSAhCbGIrTKpegHKFdUQTNwcFQqYMe6h3guypajoOX5oMSLdnsGBRsy7XqLB1jfVP56Nez7mTE+HApxRESVVHkt18xdCRUwWK6HRY3qdbrMqGZLtS7tdqUTbRdX/Bkhotp7Ve12vFTAXhwYFaRqoK2H5AOl62bK5CYdWsX8FXkTRa2tOChFWAHiChZvzwMXc3MACdAkMsnVouIKInLN+7uWbU4mj4yDLSJIrtXmOg+oeXkb/mk7Ne0gZ7Q7Yg8kp14jWpspGshLuIbINZYrMBnL1fAk4/zYGH9N0mFJQ6mmputkPo1kL3oYWPmZAkRZOR/SwDV5zuzM1z+ZEIyEeYIwZflZdFUimHyHNO/lIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a4e9da-24c9-4c08-eb8c-08dd7e8b410b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 15:11:11.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWZTzxSg0XZm2cnhKXJWgPO1cYGNMnMMT8MuppPnt6COdoUHTH8Ea4Yr0Lr9SXIi9fKecCl3U6pfH7DBugzLavxFFfjBnR52IDENy+fLfN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504180111
X-Proofpoint-ORIG-GUID: 8ayqEv_ByOQseQzHVf9c54DDtli6tvaV
X-Proofpoint-GUID: 8ayqEv_ByOQseQzHVf9c54DDtli6tvaV



On 18-04-2025 07:59, Longbin Li wrote:
> +#define SG2044_REG_POLARITY		0x40
> +#define SG2044_REG_PWMSTART		0x44
> +#define SG2044_REG_PWM_OE		0xD0
> +

please use lowercase 0xd0

>   #define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
>   #define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)

Thanks,
Alok


