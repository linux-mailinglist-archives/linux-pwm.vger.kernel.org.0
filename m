Return-Path: <linux-pwm+bounces-7389-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C2FBB64F9
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Oct 2025 11:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52433B264A
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Oct 2025 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B8E283CB5;
	Fri,  3 Oct 2025 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MduUiZA/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6260280025
	for <linux-pwm@vger.kernel.org>; Fri,  3 Oct 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482282; cv=none; b=DdFeuEj9ZSS2YDatGKinnH/BqtvPZr9SR/G1DoGzmEEnI3Tfvo5qVVcIDoT98xDRDZJPgDhTcOMP3z9VvylqlgX3eNuZTu2t6Ywt1+lVduP5HHy0C326Nlnjhpf0hmMKKGFPtOeicC1Bukh2dk/RWa0xqvbahWTxPRCjMxqhO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482282; c=relaxed/simple;
	bh=BuT24nSXvzllvHpbGMwermrZuD8IyeMFRfXE9Wlb4xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ko1grJCcYXR+v/kw/UZhu00ogmsDHqkVXhFXRDPH3YV521TKzMmaF+ShuUx5cx5V52Kxa773DYsFIZqtT3oWbCAOYL3j9tJXEFE6XXGlT+doMHD6Ixm9zd1YteyJG+/uk842kUY/5SZKOB0eHwDV2f1WDf5pTWUBJJmrSdauNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MduUiZA/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592MrOwX010597
	for <linux-pwm@vger.kernel.org>; Fri, 3 Oct 2025 09:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qLWZtUs5fVCswzg3NxSw0ymwhU21Dbhg4Nf1Ubu3B3k=; b=MduUiZA/NDh0Esax
	BTQNOqyqAHSO9Vww0gxpBsbXOIuZarsajaYJ0+bKqzAo0SsIoR361XBB7Q1bb2dv
	cjha7pakwKPu/H8qK/+RQeMyzcDwULQFXUqsYsovoee2e1AgUIFv8ytwfobSQcTW
	bydV0EmrlfK9UojlHtOdWSR87KzUCi1bcRrY6Utfag8uHkTJMif2H+s51F/XXMz5
	KaQ3WIBHJBb6Fd2NvTnZ5EY8X540f4AiwsMVS2P23ThHHUwROzf81d6Ah68OLcb5
	BmVVWLmfr2xAUatTbwu9YL6IE06WhRIXj0ZRNDjEtM526tRKC7X1IDncPLo+kox4
	xpeUiw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93ht0r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Fri, 03 Oct 2025 09:04:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5509ed1854so1358618a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 03 Oct 2025 02:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482279; x=1760087079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLWZtUs5fVCswzg3NxSw0ymwhU21Dbhg4Nf1Ubu3B3k=;
        b=GhOppZYuvU+dr+R84Zijg2mQpdLKnF2jeRHhLr/KjPv3VR/JEdESbcO7H3q17BS5Mx
         IJFA8h5sR7TtviDpxr4L9gVzriL5D4ojKah5KDsbVu5EOpB/q6P/7N4s2dEHoryTu7Fd
         I3buj695GTkI7ST9b5mHCyo/aX8SPn2eo9igwhF9vnWQv1V3TREOIkDUgnBs5qgOMtUc
         cikIf0uACdxduD1SO07boj3skNbhMpOByTGSb1qaoP2skO1nzpwn37oxcRx0NEAX7Qr1
         PodoV1SoLXqzu6P+qQ0NyBQ2hZt3uCLDNT9cEpJZ7sjneRID8BORzw93Uz2hkJ7csW4L
         iUbw==
X-Forwarded-Encrypted: i=1; AJvYcCWlyPisvvLxMFTzgzukf5Go97HlgwKPyQWxuWgHumvQhradZbBQ5j8SoYmn15QaQNcetuyQn3qjg6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3IQnxwUv7BSZe8xN7KVFK1fj3GgS/7kI8b4EHPNzzJqv4wZV
	WI6o8uc3cNarwBUbPfkUI8FHVMdBsvUMV7K1HIvBjs90bBm5VYt29prlH+QckJmDBrjoJ3BjA0I
	0YOAEB1fOtYk6R6wOsb2CYSjKjQen3sMygW/3w+6i7LLzeRD3hVQQOtR80JjCf/D5uRKeSaM=
X-Gm-Gg: ASbGncur9TDY7T1FJyb0edI1PBwIvg4oz3Cemp5x21YHxcGxFpzDFi5dXPwDfD5+IOm
	+0pfe98ymytWGG/YtUdoApmwKWGqA9epmvjjWDMV0MdEOQOVWUC63JfIERXZAgEyRh63hUNO/h8
	/AT1YhSqvEkm228bMblOZqLFbSOEPC+LStKfzXW41F8/GMCjknEyi1LrADamZaVQnKPLSrANPKD
	dutPf75Onxc1fw6Yj+3FtGM4MUCFJ7sORRw9zlsk5lkVtjXeegSfr4si6zKFYIO02kSC33fjPzw
	nHVr5e2zwN/Bk4lsCqyjnSAdDHukS8JqcMD9qiOEi97/zl/2J9/o/9j1D6ukh0bu/9Yxy0epmsv
	6EZ3RAnUTzGc5Kw==
X-Received: by 2002:a17:903:fa7:b0:256:2b13:5f11 with SMTP id d9443c01a7336-28e9a645c5emr30186805ad.40.1759482278653;
        Fri, 03 Oct 2025 02:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8osZ94IBlmYS6mfN6OxharIdntATWBnaR1H/rolxzIfSfK2AidWvRxzbO2yAgkm6oFVwbqA==
X-Received: by 2002:a17:903:fa7:b0:256:2b13:5f11 with SMTP id d9443c01a7336-28e9a645c5emr30186365ad.40.1759482278141;
        Fri, 03 Oct 2025 02:04:38 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d95bdsm43659375ad.119.2025.10.03.02.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 02:04:37 -0700 (PDT)
Message-ID: <3cb50330-effc-4089-b80c-d454bccc63f3@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 14:34:31 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Add PWM support for IPQ chipsets
To: george.moussalem@outlook.com,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Baruch Siach <baruch.siach@siklu.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX0YqqfJZYxEEl
 ppG0lHQw2RQl14al0KkbNoYOGpOO/26TbnzXp8GUOLuwZJufc2BmEDC0jbfSwOwMhsv+gOtshdr
 0QoghoWZcr4BnO9fp67yR5obnbT3Iam6zmCa/Ran361SM+Eitwgq5fyACHVkNeT3lOl6I5NHYx5
 0Q6ycqfuJUoARZVCClS1BS1b8+t/96jolSZlrMsrkamOItWoAV2Ge6yj5lIq74gjtV5PcAbwtQ/
 6GFbf4l+9R0nu5YbjIHN498yFyJP1oV00KYRLgIYcxTCHUzhXo1qxGbKxRqvt3ItwC26iu/Om6T
 abECt7qAeqroQCY8f8RZZA0sWmZM8AZOl7HQUMH+PdNXIqQ5Kty/8Z3hz+kZm94yDi65Q44nqcX
 LvcoZoluSlvEvUac+dOtkexsQGrBfw==
X-Proofpoint-GUID: JwBNKnNd0GvbpBOr7-Ypp--WTanl9HuG
X-Proofpoint-ORIG-GUID: JwBNKnNd0GvbpBOr7-Ypp--WTanl9HuG
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68df91a7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=MaTjDNABAf216yt7wJUA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041


On 10/1/2025 7:34 PM, George Moussalem via B4 Relay wrote:
> Add PWM driver and binding support for IPQ chipsets.
> Also, add nodes to add support for pwm in ipq6018, ipq5018, ipq5332, and
> ipq9574.
>
> I've picked up work based on Devi's last submission (v15) which dates
> back to 05 October 2023 as below SoCs are still active.
>
> V16:
>
>    Removed reg description in bindings as the offset is not relative to
>    the TCSR region anymore since simple-mfd support was dropped and PWM
>    nodes defined as their own nodes, not child nodes. Updated the example
>    too.
>
>    Dropped patch to add simple-mfd support to the qcom,tcsr bindings

George, thanks for taking up this series.

Can you elaborate on why the qcom,tcsr binding change is dropped and 
made the PWM as an independent node? IIUC, it should be child of TCSR 
node. In V15, I see the qcom,tcsr binding is applied and *dropped only* 
due to dependencies / lack of information on the "pwm-cells" property.

Thanks,

Kathiravan T.


