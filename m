Return-Path: <linux-pwm+bounces-7393-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC754BBDF64
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Oct 2025 14:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098A23BEA91
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Oct 2025 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE927A903;
	Mon,  6 Oct 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J5+5RvO9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A127874F
	for <linux-pwm@vger.kernel.org>; Mon,  6 Oct 2025 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752398; cv=none; b=WEVqy1iszdMsclfS8tCYiUwddZM2jx4LePwq2qho20VegMamLn/a6In/10X8khuB2KUyP7a7xe5ryTSYLxQD1OSzR2j7PhYdHon8vUv3gT7FlFxBH6hJHIqFGQrS7/pnU0/XlcNRyTymwkUUCd2qCjm8xrUsA6skHDhwqBTnBr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752398; c=relaxed/simple;
	bh=HLxEdvzR/XmxUl/mla4qo4fEhWeRdHcVAsmMcuzaVAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bP2tQuieuZZYRwmJSj0CDz3k6IefFU5DTG74rXJGusByF+HRc24NiOtwJUm3EaBkI1HJw50irke2Yhw5bdqS3mezZFJklMdWSACvGg2eiWU8OAUzEVPv7yAM4V+8bx6BrS2O3uyKsOrFE+gShFeb+EVzFUg92/me0DbCyOQCcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J5+5RvO9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5960d3vP001346
	for <linux-pwm@vger.kernel.org>; Mon, 6 Oct 2025 12:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HLxEdvzR/XmxUl/mla4qo4fEhWeRdHcVAsmMcuzaVAE=; b=J5+5RvO9h6kgmyJq
	3s4aN+jSgg7ZlgIi39SDGq/U8iWM99LpVnT6S6sRBhLTewpejXsIAnSyOMqk9Qf1
	NilNGFPs/FRLZNUHq+pCPse4wR8eEQqJtYyYEcdZ7lB4/s/ZCokSXUHWZsjZIM7w
	q1YBM4taYNT5aAn6YS248KlL+n9gAfNl64iQ8s5Js+e1ssgzBWRplkIBK+0/luNn
	PMAliVQzD349+IOaXSlCt27FCUYfinhylaMjZVQcWlgpawTrGAa8BcBMo2OlF+wI
	6UrF7eUgGVj76U6Vm8VlrdQ00B/VZVW+wUP4GMjOhX+D2JQb3J5W36L056uZ4SLW
	USF6Dw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1kqhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 06 Oct 2025 12:06:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4dee3f74920so8312881cf.3
        for <linux-pwm@vger.kernel.org>; Mon, 06 Oct 2025 05:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759752395; x=1760357195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLxEdvzR/XmxUl/mla4qo4fEhWeRdHcVAsmMcuzaVAE=;
        b=ZPorqKD7Zvm9bSqAJPhElvLxb5yQkZKXhjkAm7mMqouf4IRLSElH/Dy5Ts1cj7U6k/
         Tks7aCyn4GxaQ6P1FLxM80RTgEuDbjM8N+aI6dDa6sMPWRFWnHbTPflviQPcqcbrI3Jr
         dFP92/ctx+NDe0SRpkSupwv2y5fL6cpu0APkjTI0BPk55W3F2Ivp6AOESPNF0QpDIefe
         Pyzid6g5WdcWXU3kUtUpaUkB54uMtP48m2/7i4xBG5aqvrkPFjDmdHqGm9/+kEkUBXkF
         +IQCzZU3OTVOxkYxL/equ7r1rCU9/zBoY76JEcjgC4eonJISrMDDotaOAgqD+qZt/iC9
         mgag==
X-Forwarded-Encrypted: i=1; AJvYcCWSqTumJNQJc8DqtdkdDFvdplGIFZs2qiTe460XaeZibLJg1T7XpPvfe4nWsy4RNPQ+wS2e4ZPIntI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlePb5lpOKMRTMkUUW4m9sx2rAcxPARfzLKd1UH/jnGjTT9eYo
	V6BVWFsVjb4RJRUnfGz38U9sBvUGyCZl5lRDqXdcL+ugTN+wWFWjYZQUQkItkGZXFcYC6RotS8+
	kBt7QyneritTK2f1iuSoz6ui8Dz46hhT6qMPzcLAqIdnUOTuefGjLNa309D/Lp2INbahIi4I=
X-Gm-Gg: ASbGncudnArSwDmUr1hi5hv+K9YIeKEzR4GsaRSMt+rljxeKul/WaUr0VqlSq1ZJJqS
	Ng78dRwWyVNpSCbT/VjOMD2S3K5cdNx82SlgBeYHBKypCBV6TQTGSubZfVzWfUlJZOiamZouqU6
	O/OnTY7IpOmribWCnPODSjCdi6AAso1Zfq4KKqJozuw+CK1hj6CmwNZVD6KieV6HVplBMAAMLjf
	7jDlQPCC3qfPRxidagyfTyrSg/BmWO9bbW8+Pl0liDxCg8/myWUVXtCeuM3jo6RqHH4GIqM9OHZ
	YitMQ+DsWXXelj5wzQdxQCwqToFzhHCEvMuh0nD9gpuNV7yHeoiRvAAva+5PAMkYolcjlqDHC5q
	mRDrJym1JIpp2qk9ws5ke6UD8iwM=
X-Received: by 2002:ac8:7f41:0:b0:4d7:6c8a:4792 with SMTP id d75a77b69052e-4e57695639emr101645521cf.0.1759752394854;
        Mon, 06 Oct 2025 05:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL5Iaw44FNavlmz+iujGEn4Rtr8EjnBdm2ElAhoWxAuwKxOPHJ8yJ2UwPQnRwz4KKHIwtvMQ==
X-Received: by 2002:ac8:7f41:0:b0:4d7:6c8a:4792 with SMTP id d75a77b69052e-4e57695639emr101645031cf.0.1759752394248;
        Mon, 06 Oct 2025 05:06:34 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b6927sm10231021a12.14.2025.10.06.05.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 05:06:33 -0700 (PDT)
Message-ID: <2ce295a2-586c-4fb7-ad10-3c7734e1f590@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 14:06:29 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Add PWM support for IPQ chipsets
To: George Moussalem <george.moussalem@outlook.com>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Baruch Siach <baruch.siach@siklu.com>,
        Baruch Siach <baruch@tkos.co.il>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Devi Priya <quic_devipriy@quicinc.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <175936202881.2426650.1624694657690403545.robh@kernel.org>
 <DS7PR19MB8883CF5D3DA8ED32B6A919449DE4A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DS7PR19MB8883CF5D3DA8ED32B6A919449DE4A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Pz0UZhk7BJczRAhXV81dUqvUc3nbjxPH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfXzQT719DwWRzk
 v9f2o3rqebTeDs9Qj4sje61QqGeZzFJVhW9rVtse98X7x2r+5t/dQ4G1vYLp4B6QqBLZVj9zb3X
 WVpvNZeb4FnwUZ1vQaAurH/XaRA7lNd0xMsnaUjN+o/paUu4GYAVZKnF5AAnnaRO4XBSYAlMHDY
 QLeOH5R6lgFHT8prZl/a3zeqLRmTXLGL8lmYUN7mqnrzxgnHpz3jTPk7uz7h9QsMWejPg2lOWfe
 XYY0zQfmdua4Qjll0Qk/TeBy6ontsYnWRALLr9ysn7NIPE3zn0XuAMiQ80puFK6cx20rh5095w3
 qVYsdOkbia5GtXABDOqTjcKdw04Rpsw9yWxkGGbDu/YlWdlk7BnwwBDsyaMfo/XLBkFjiBQejgq
 oBRxNBNQOXTz/BxzT6l9EaIA0YF7BQ==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e3b0cc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=2C6YHBdLAAAA:8
 a=v4cj00jlyj8MMA1A80cA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=yxGMNg53M24zlVSZdvMH:22
X-Proofpoint-ORIG-GUID: Pz0UZhk7BJczRAhXV81dUqvUc3nbjxPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On 10/3/25 9:06 AM, George Moussalem wrote:
> yeah, my bad. c/p error as I moved it out from the TCSR node.
> Ran dt_binding_check on the yaml, did dtbs_check on ipq5018 so missed it
> for ipq6018. Will be fixed in next version. Waiting for feedback on the
> driver (Uwe's?) and on the dt bindings (Krzysztof's?) for adding
> additional compatibles. Will then send out the next version..

Please see Greg's note on top-posting:

https://lore.kernel.org/all/20170823231800.GE5193@kroah.com/

Konrad

