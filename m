Return-Path: <linux-pwm+bounces-8097-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF/2KFA7g2ngjwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8097-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 13:28:00 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16836E5C77
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 13:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D46E308011D
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFA3EDACC;
	Wed,  4 Feb 2026 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QB/nQEOy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g8uZFeLs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF23ED139
	for <linux-pwm@vger.kernel.org>; Wed,  4 Feb 2026 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207922; cv=none; b=sW9gXZJYSgaVIrMnrcLPEMqClkJUqvBADaA1MovetJkVLmf1uLksZlaO18VeW7BN9zJLKji0TlpNpODAvtvaGSWBzq8CSZ2/n2V7vOrYlVJZu1+jLeqqsiI7//mAV53JsKuYoW4au43x+urjiQHKxdgTXb4C+8KJO4pVDnmP0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207922; c=relaxed/simple;
	bh=6Kh/AYoLO8ss+NbJLG/JKMRjDMnQ1uQB3la6ULX2+sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIn6M1yfy6NRLdsWpmU9BS4GxSIVS9KUWQjvQ05AAQedrIu66LQi0c9VkN6BAjtqNvSHDqiiQiS/DvqSVv2pa5Sy7LLXoo5NpIenw6Cb46Hdbd1gfheZGLIyFY3uR5JssILr64Fz91L5tGAOY0Yhk9TwcrOEiiYd2yDVZCIsiMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QB/nQEOy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g8uZFeLs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CImA41881152
	for <linux-pwm@vger.kernel.org>; Wed, 4 Feb 2026 12:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dXXKzBNQVpiEdpTNFRQ6r4ous0neu47vocE7cIc+OHg=; b=QB/nQEOyntBXssmW
	nB8qJJkDSK5hnrC0GzYMIn7U2cw8YmYpZA7tm7OI4UFKgS/+TKkAAcQVqA/1wDF/
	3o5i4TkdFKAP52H9WrxJ9nR2i4ZBpTsl1OopjUkAXRFQJEtWYT26hUtKyy8x9btp
	74QXsgJz+HIIAw7A3rTwclVd67vCExr0+qKx4Pp8NIUFAglA6JxuhHwxT/Wt2xms
	PN2Ak8hSwkVAnRkkM/RF4UJ8LzDnAPLIBU3CzGWibYpsSYb/SQDsdoini5yWLcQK
	k8/Aq2ZE5ONo/fSwHsn+c1vqpF5rcjA25vf1/IlK9MAUD77uXF5d0b1uAL0aUqnF
	10sGVw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43n9retk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Wed, 04 Feb 2026 12:25:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c533f07450so179125685a.0
        for <linux-pwm@vger.kernel.org>; Wed, 04 Feb 2026 04:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770207920; x=1770812720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXXKzBNQVpiEdpTNFRQ6r4ous0neu47vocE7cIc+OHg=;
        b=g8uZFeLsKpK5Puhkbvz0d/EUy9N7cvNrlbHu2EgzZX+v3se4HdQZtsXvkini2aVXmp
         YoQwEhCSvl2KHsp3sJShhg7BVh+yz/eQ9e9l9xr9dRu+yQsrYopdsYEvkCc3fd/szLjs
         /5glkQbxLx0iZxdVJMdzNkORuWIFagTLlwVFNWZ/jCBuPCrA7n29m8S5rZiaRipfz24o
         J756cAjZrrgIq1/2EFKtRi+kXhBJel9K2zQqHWpVTsN7ya+yivRU+7krYX9BPYgs1exA
         hzbnJrMNkUc2RNMlZB9KsVx3IpQmnaMjD90oVgkUzbFZ595ig84xv0IhbbkjkZ0eKAvb
         VjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207920; x=1770812720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXXKzBNQVpiEdpTNFRQ6r4ous0neu47vocE7cIc+OHg=;
        b=VJm9MNtYYR7eA2JCriverM+V/ZPdcKlq20B+0mmU11SmumJJg9Ex4Q8H2QzJUykzmc
         bM8lyZDi+Mnl+osnLlbNXSc6e6gZful9ivpW3cmA7g6NW1BTrxeA7VTmvMoGOjD3NFee
         aUao8uir+BQCfdb5TOfiBawiv2Zy4ODB6aW4woW8hnFOaDSeBxJtt8/V57hYxtoZm2vr
         VlEkSgkbqqGCGAM4nbe9pwA/Olj/GWG02XEuUco8TK0UQWo+ytUmYCZYUhdWAic7ahYN
         BCSz9necpFVaU7SP81awhDri34Q9fww+5ae5n6ebxoedx/3llnHUMTP1CxSjjEeyTaAp
         z+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUoQq+FOtAFI1un5VILx10XuOoIVEXMMM7IyYF3kaFm2A6gtz+NcXekpx9ELs0l138bbaEcY5FQZao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAOgTmm9jdVF6ZDnwTBWi3lp87UZ8J4Oq5KQ5RATwNmtwO7E8p
	M/LdVOlzmuvyySWn652sXw5qyip4u+ALhzzsET8oGmuMW36DnvDUuLr5oxh7RgoQhqgtuC3mKFt
	kzHqNsAaVJPgkgoHJFtQMJ2NpKCrvS6oD/4emMEoRX6lRHCVBOvj80bfkllmf8YM=
X-Gm-Gg: AZuq6aKLEfU8m0m4Ky7tAyKOzqPwsRORo9q9v5gt0ot/dW3kbB1TrvVd+/0Up1KOdYW
	lAz+xXRdg34PEB21zpkWqy7N9FEQD5N5BX//RxELQz3z1zsR0Aq68rIHKS0XHLc7lldJJ/wB7D/
	ljvKRnQSZvYkHV+tqvpyx8vCCMMBLVCM3DN0TNm6hagE/8DulIzhrnDltEXor81fIgaVxUvzahB
	KhmtcNUKbG1j4FSBcFnWQKMvH/T8l8S8QUElAupfZDNbc0qA5dPArlQCO8TkKTtGxh8KngnN8Od
	z9ZuVXPUBkqYCZ8+5Z14FLZPbPZ2sjhTeaZDdVof4UeHWJM7iRhB0YPAtIO/HQlJTI4UYWpj++L
	iiYBkAQUI78P8oA9Uow7ljrhwxiTP3VbmUuWQSAupYUO3zYPwkLKniVSLkS6E8VI+XFo=
X-Received: by 2002:a05:620a:199a:b0:8ca:2e7:56c5 with SMTP id af79cd13be357-8ca2fa80e59mr231081185a.11.1770207920251;
        Wed, 04 Feb 2026 04:25:20 -0800 (PST)
X-Received: by 2002:a05:620a:199a:b0:8ca:2e7:56c5 with SMTP id af79cd13be357-8ca2fa80e59mr231079185a.11.1770207919820;
        Wed, 04 Feb 2026 04:25:19 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fd115d8sm119940066b.22.2026.02.04.04.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 04:25:19 -0800 (PST)
Message-ID: <8e6e6030-6fdb-4df3-9ff3-12a1d420059a@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 13:25:15 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 4/6] arm64: dts: qcom: ipq5018: add pwm node
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
 <20260204-ipq-pwm-v20-4-91733011a3d1@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260204-ipq-pwm-v20-4-91733011a3d1@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MyBTYWx0ZWRfX7Fw09aqyx2TT
 QWa2qYgccE4hVfTEPI2fgPKakQ8rF/Wf2l9mJlH53NGAiuOrzNYKrTZxM7LLo/zFNF2ehS1cDgB
 kW5YljB3n8lHJKkFPaAidE4N51lbSOurBYxUL9Lux7VAfrxXa/vKUhgeJcb9ynrOkp0B1sSV4J0
 WstB1DpbC+vSpGCtmp0/Mz2hVGuALNKttOvO/4H0gxmsQFq/qwD14u/2pD7Mq2h4ekeU3g8RgHo
 IgI1Ck8+34txCxf8OQU65TCSiBbv91Lase2jvrWXBKXItvBQC7eButmtirwJqQoeE12MOZAQf9d
 eLbYwA0Q1WZp6wwcFBG3y3xO6VT1mrjirWdKsNhnZ2eO19S7SKfzxohwrN5iSBwu2gelyi13qHh
 8ulOrmDSM9ZXJRHeAvzppqC0S8GW5fQ5m468vHjUr7OoE4XcTufFzhGUYkXdIhVdARh+Vfd+uFK
 SgUvJPJvRuOwwquE4pw==
X-Proofpoint-GUID: gCs_36YpS3mcf20TU2HG72GaKQCXbXfV
X-Proofpoint-ORIG-GUID: gCs_36YpS3mcf20TU2HG72GaKQCXbXfV
X-Authority-Analysis: v=2.4 cv=b42/I9Gx c=1 sm=1 tr=0 ts=69833ab0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8
 a=pgNS_SGoCABwbyoThYAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_03,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8097-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,outlook.com:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,tkos.co.il];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 16836E5C77
X-Rspamd-Action: no action

On 2/4/26 12:25 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Describe the PWM block on IPQ5018.
> 
> Although PWM is in the TCSR area, make pwm its own node as simple-mfd
> has been removed from the bindings and as such hardware components
> should have its own node.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

