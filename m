Return-Path: <linux-pwm+bounces-7391-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D6CBB6637
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Oct 2025 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5381897D53
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Oct 2025 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CE12989B4;
	Fri,  3 Oct 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ce/yHVoC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FCB34BA40
	for <linux-pwm@vger.kernel.org>; Fri,  3 Oct 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484383; cv=none; b=XRAvb+WpwqDQ4kXHx8/o5N9FDhzvOTDYuxjuhOCkvAHf2Hkpc63BVSod/qW30Ti5b/7GDsntkJcHwIaat2MnvMol0TW+wDyObhi/QE1CVrFDLKZN5xi0GoVxYrF3jI0EAoXGKluGpH2qzihu7JScZPYTJaqtQW4drH0VMTRBh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484383; c=relaxed/simple;
	bh=SmXYDokhFwrv+zy33WxsUhFm40t/pKJa2ltf9BoIugU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4TH2RvwqaPtFHPppDIN1sBTkmODmxmHmHwjto+zEM49VbZ2ZnyUGQ4eEZMLgTPhssxKn8X4eKIktgzlE9q2J5PoTcyP0SidmmoMFsl9WREDuBOv8EePbUulgYkvqkrLJdCq6/G+jcynBIXUsDdTVQ1KoNpe2615I5L7XSuB7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ce/yHVoC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592Mr1Z7009300
	for <linux-pwm@vger.kernel.org>; Fri, 3 Oct 2025 09:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	04eJkInxO2ENPO6VxJdXgTlBaS7nX00s6IyWW9hvzsU=; b=ce/yHVoCO8wPuS8T
	S/A0T+mXL6oelPbL5oOvKYBJ4LPlPW20wRtsw/kZnGBGjUobOrLW/QGhtQuqCN79
	lZrKFNM58DEVb3tmnJPEfd3FLu0izJhf1V2Zl+HAYbKmwpP4lioVERpgNnsvSFS8
	vd6AofobY8FPkYjne+ByoAZxbdi+61HPGbfdOydfy3ZQ/j/Pd06iG6ja2felx95l
	Gx0BrFQVk3qKy6CrRIDCZd1YOQ/zyL4TpP4ET2aYrLIhzwoVl1IYYqrseLg7bT91
	EAZHQRJcQQKbwtKkqcyfJoR3XQMGubzfHmBO8TELK4+734aUJoxbyiih12j/FOSz
	adwqNQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93ht3jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Fri, 03 Oct 2025 09:39:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269a2b255aaso43504635ad.3
        for <linux-pwm@vger.kernel.org>; Fri, 03 Oct 2025 02:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759484380; x=1760089180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04eJkInxO2ENPO6VxJdXgTlBaS7nX00s6IyWW9hvzsU=;
        b=SJFMiTUACgUcWboDJ4nHxuvUZgGT1YsR+35+wL4Zr2DwSgq0L6hnVKRsCaRfhE149s
         62CpSflh8Fv+A9zvygTfYpE3mBO9mFJ4GYR04dnvMpdljsogZvlC9R7RTUUZsSSt87Cn
         /45DCpgLbzfkyRuvbdh83lGz0C0plIdGgET5RifBGxto9CRSQxnNY2WqTEk1h1p3nQrc
         ciw+4P7L97qF3lyn5RsOLezA3GhA5omGTKyLDMuUAmv6kVxw+FnZp7Ktb3Ls4XiZthCB
         CkhbSssHlxTe7m1Ud9TamUJDconx1eIs0UJnlAfkZqCsGDHtNE1rYSYFLFLe1RSG6mNC
         FS8A==
X-Forwarded-Encrypted: i=1; AJvYcCWH9oRiod7ZB14D5urTEF+bPb4vrBG9xsWbHNoLFskkKRRhZG0uQB3Mn3ym8141eCsbH0NpuvpJMks=@vger.kernel.org
X-Gm-Message-State: AOJu0YznsnMzrss9Jl6Z7claR4n+G5AfJIqGeozCNyckso4V4pdxvAKK
	CTJ7cxtIxgTKZ2tDrGxWO4fE3SudAcTfos6FaDmhNpPaJlZMRxxoSBiEXBXt7gdJOPXfiKV14Oj
	AuZ+6xLM8bbFyaIDalyov5FYcOr/R/G0FhpB798rGULsmWa7rzkaWuTYDjMI02U8=
X-Gm-Gg: ASbGncs5uuOByz3iDZ/LHcU4+D2XcV2/ERTMX3hT9dp/OcZkChs3etOlMnCEB5oXHwQ
	pVpBh2t01cFt0RLA6Vts+siuqPsYjiz5CXBZALe388zLgZQuYpbi9yPI3DJIK80Pg7HV8oYKuyK
	C2Dwf25o0IQHboNYAZ7yTZ8mIPmiDsXbtPrVp6z/tJLCnglGX+a6Ec6LeUZ60OXnq587l/tnVLn
	LPK5J/tXgAhoNpwHOmnx3ImZhZCWinnbVqlYvkbgpC6r7yTesI2mSwMpKIHqZH2qSuKR8SjNWfv
	DGEypsPGgLzd+JG2vqUFaMIS+IWixN03CHl6eRC3qUbmpMzgQkt55ZT77tVRnlutCzVZt9sEExO
	E3uPqpXxbluyQ8w==
X-Received: by 2002:a17:903:1b03:b0:269:9a7a:9a43 with SMTP id d9443c01a7336-28e9a5bd5edmr27721075ad.10.1759484380349;
        Fri, 03 Oct 2025 02:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1F+ny00A4izU2Vmt4qqieA1wCTH034JmDPn6Ou6qFqpyQ/6nCQyCk6gspjRmbunlDp0O00w==
X-Received: by 2002:a17:903:1b03:b0:269:9a7a:9a43 with SMTP id d9443c01a7336-28e9a5bd5edmr27720775ad.10.1759484379904;
        Fri, 03 Oct 2025 02:39:39 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1f19ddsm44936695ad.127.2025.10.03.02.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 02:39:39 -0700 (PDT)
Message-ID: <8cc1428c-dd23-4b20-8c79-5d6e7768d4b7@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 15:09:34 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Add PWM support for IPQ chipsets
To: George Moussalem <george.moussalem@outlook.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Baruch Siach <baruch.siach@siklu.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <3cb50330-effc-4089-b80c-d454bccc63f3@oss.qualcomm.com>
 <DS7PR19MB8883BDB4C3147C86F062A4B29DE4A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <DS7PR19MB8883BDB4C3147C86F062A4B29DE4A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX7roqKGrFozgn
 HUCuEmbZBAOYVxdLhnE3RD7e548sQ6Xbj8bLcvKdP7z38O+ITmNGTpUBvPuj0VKmDOKVtjOPg1Z
 y9xp1/sclZgWfW6GZI0+NBMXDuYyWDcme5VjiN2hE38zftbnyKxMc5lLf6IOvHa5cRZdPEnhsJn
 VcmpBUAh0wN0/aZQj7ZAa2SQ2/ayn9IJclkxNbhdGClPq9mAtfGjbj6XIpBXNC3YYmT1dxv1vDZ
 1u7BjlyYUnPHIpDjsigUwntCt/Ihl13ImOzfi4vnyEaHwuCsUu7iC5Gu6rraqwwTY2g0FoZN8IP
 MG/VAn934xy4tv6T8xLf92FgB+P/YocYNn0M+Of/xFpRK6Hl3qOL2Z2rRu/eHnGqmbXQITjeNXV
 n1F8v9xjp/MCD/an/ZVtltFL3PsfhA==
X-Proofpoint-GUID: JhveoxutCi9JakaOhZJelPvXpMmtpQe9
X-Proofpoint-ORIG-GUID: JhveoxutCi9JakaOhZJelPvXpMmtpQe9
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68df99dd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=LDzoOPf9sO3yNRZ_Fi0A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041


On 10/3/2025 3:00 PM, George Moussalem wrote:
> Hi Kathiravan,
>
> On 10/3/25 13:04, Kathiravan Thirumoorthy wrote:
>> On 10/1/2025 7:34 PM, George Moussalem via B4 Relay wrote:
>>> Add PWM driver and binding support for IPQ chipsets.
>>> Also, add nodes to add support for pwm in ipq6018, ipq5018, ipq5332, and
>>> ipq9574.
>>>
>>> I've picked up work based on Devi's last submission (v15) which dates
>>> back to 05 October 2023 as below SoCs are still active.
>>>
>>> V16:
>>>
>>>     Removed reg description in bindings as the offset is not relative to
>>>     the TCSR region anymore since simple-mfd support was dropped and PWM
>>>     nodes defined as their own nodes, not child nodes. Updated the example
>>>     too.
>>>
>>>     Dropped patch to add simple-mfd support to the qcom,tcsr bindings
>> George, thanks for taking up this series.
>>
>> Can you elaborate on why the qcom,tcsr binding change is dropped and
>> made the PWM as an independent node? IIUC, it should be child of TCSR
>> node. In V15, I see the qcom,tcsr binding is applied and *dropped only*
>> due to dependencies / lack of information on the "pwm-cells" property.
> Please see below patch where it was decided to drop simple-mfd as TCSR
> is configuration only and any child devices should be defined outside of it:
> https://lore.kernel.org/all/20220909091056.128949-1-krzysztof.kozlowski@linaro.org/


Hmm... Sorry I missed to check this one. Thanks for pointing it out.


>
>
>> Thanks,
>>
>> Kathiravan T.
>>
> Best regards,
> George

