Return-Path: <linux-pwm+bounces-8099-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBO/GuM6g2ngjwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8099-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 13:26:11 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C45E5C36
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 13:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2507D3003BC1
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145F23EDAB6;
	Wed,  4 Feb 2026 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kURDxo4b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XVlUIUMd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36B53D7D8F
	for <linux-pwm@vger.kernel.org>; Wed,  4 Feb 2026 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207966; cv=none; b=k0BRhYPkJvFEN8/o8DfkEIoaj9SGrxmPfxX256oX1Lc+MeigpExokkRAJqGrs/WcnPGSQTe/rscxf7yCKapJ7CwIL+dNMHi8h0IvMtY70frctjN3KL+/GIA0lIQRJ3PeRewz5j/Zkp5qxf+Z49d7fxFwoxkFzdQYtSXEQzBcv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207966; c=relaxed/simple;
	bh=DOMXO6Luw7aMAUULKOe3D/L8ZURykxphlLaEK2EO/Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pliFuTJrYlWa5vG+iuln0OazjUxaIUuno5/6M/L1K14V99L5NrFsQZMBV3uUIJtWNes8iyiEcgX7jpk6LeYFWZNlm50igxTonnKh03nAU/LsXtW6ukQlPleLfDtM1odgREEbM8uYqdd+TfY1EiO+nwlka+8y5gUHzu4epGTPaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kURDxo4b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XVlUIUMd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CITJU675066
	for <linux-pwm@vger.kernel.org>; Wed, 4 Feb 2026 12:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	krXrChzNGJk/4lgJGzIO5fFWAQmjQI39ECb/acG3dfw=; b=kURDxo4bg8jhDYXp
	v+AVJv+M0WzwMExA4ExCauy+EQSjY3kdoc5MIL7WfPo6iNYriLKTkKhRB60ujU3f
	GZGGSxgrbfakU/ihd+Up+BPIbrGrFjxiAZnpAyVrnZSx5uSdhIjz4XafTE6YXbTv
	F86K0giF+7ShmejoxCq3fwkabpNQ1ABwGEwMFImbV2EJoAVc7yE66gNDT1EsNSMW
	7VsfJ20hyRJsUI8FZHC1f5rq5LyU6qb6QTL8JhSY7PY97iy7ZOYAxifyql842VoI
	QxZc5Y5KVWXaq2nb3kaiJvDKxBKU2i9pZWHBtYTPd2Q/+vwMJZ4YIPhnSOQ7Lwj3
	sYLSIg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3h07m9ps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Wed, 04 Feb 2026 12:26:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c522c44febso169037185a.0
        for <linux-pwm@vger.kernel.org>; Wed, 04 Feb 2026 04:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770207964; x=1770812764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krXrChzNGJk/4lgJGzIO5fFWAQmjQI39ECb/acG3dfw=;
        b=XVlUIUMd8iQQf6ySCAt3DRySaQjrQi/v8eW+t+z5vnB1vb5J4tX/QrJ+sLua6FAgro
         hLatkDNFE5fKQLF3lfxTNjNCxDLa0ZLXDJvAU0EKOtNt2gjsC2cpAeWSak0SSeiB5E8O
         5ueKinULNYb79nkjVOWDH+l6MaAxc34MRaAJR4eRPEQDMvoR32mxTLh6jIemyxKbHQsG
         rZB2179DpJfxd9Ld7+q/TonnpB06qYLmAAnFGkj27bK6+GOql0aJoOdfNx8druFuzAon
         dcuvk9sEGbk4w1u9KVrX0OIBaTO3AXn1KbrINYZHjhe+hlFbV51Gr8LxXn53EN/Mopnl
         xFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207964; x=1770812764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krXrChzNGJk/4lgJGzIO5fFWAQmjQI39ECb/acG3dfw=;
        b=d8bwGFBFowzonxALXlv+EGBqopWaIERqZbON5QHWEFEzlW649y/TDRc5RjmwyHxxgB
         2+KXazTwdXO9XoeyMdyxGaheDDK6X1esRw8bHt12tUG0McOqDBmQmaJFT7Rg2tGTnx6r
         R2M7CAGz8MEsVKm3DcjTD7c0C638e09JcIFP9N8cjfmvVir40bTN/JLX3E1ohUJfvYZT
         kOFZ5QJnmQ+Qk9Y17rlyOSfmsZQ8E5dMoXupVZuZNwye46t4yUsqRur440A76+JmL2RV
         HSZ0jTx+OW2G/b1V99ETk6+D8EHI0VVNOWwgcBvRBQM+wjLae3cMfaav62/pE1D7Moqz
         6zsg==
X-Forwarded-Encrypted: i=1; AJvYcCWtlqEjY/DmLhjLeyCZivksTbdMfww3xr5bkPqdPJzXvCNkRAgM149mrEzooEucyMhQech1VMZNv6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCzj3SnAazCi/qRk1RK5S5ESReew9Ld+tN/AtFWK0D97I/EZy
	M68J/W6Vv6igZt8s1ATrakF701L/sE1MNgSpqCW29eV8UCMIL0qPRi+jmsHNpi9bfKOJLdevXI8
	zhsHBdjJ7pmp3xkz8OU7WVIxYOWo9ROmJ3hZlKhlV9lU6RbWXPuwly5Ra7GFYtJ4=
X-Gm-Gg: AZuq6aJz21H4vgbFB+jeyhBVUNJ1QfDQLx3BEIGK9F6lMU0elbTa3mZhKl1/w8C7o/7
	mGfRaUKsLW4iz223ypTnbuZjmf+iJ+yQj+wbobM5bygrw5lOYytyUp/o1LViYny2It4RN0aOQNt
	SbTPGVDuayXTChlPf1FbbSN80t4qd0eJBwhAR7FLNqAmNA79WuMsvkx/Pdz7coeZEd7Frf7+wNm
	SgIk1zxOxcQEsId2x0tqVxnj09wlAGAd2LCvocwxEhOVM4eAj9rOt0bVv+Vexv1hnYCLfhDczZu
	x6t/XeOE/0eziIlzzH9W96LgQtL0oUeglqZhgF210kq2rprNW0D0OGMH4WvR43JEzV2epuyV6dJ
	Kj0KWXZChuF6WcPSvjr4tc8BEuotRtFzqmzaXLaagoi2+WBsVwG/cVRyvJZNQg0mI2BI=
X-Received: by 2002:a05:620a:7105:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8ca2f82c982mr271706985a.1.1770207964072;
        Wed, 04 Feb 2026 04:26:04 -0800 (PST)
X-Received: by 2002:a05:620a:7105:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8ca2f82c982mr271704085a.1.1770207963581;
        Wed, 04 Feb 2026 04:26:03 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef0ef9sm118947166b.40.2026.02.04.04.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 04:26:03 -0800 (PST)
Message-ID: <6f57b23d-8716-4fc1-b1ad-a44268e62663@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 13:26:00 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 6/6] arm64: dts: qcom: ipq9574: add pwm node
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
 <20260204-ipq-pwm-v20-6-91733011a3d1@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260204-ipq-pwm-v20-6-91733011a3d1@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MyBTYWx0ZWRfX1NxSgcfkguc2
 LqnzYkrTOQlla7EuztRZBWr+JK7VZwsn3sGTyMsGDYJPcinWfCXfOCL7bQK8y1HEwJQrA2xXtd0
 6FOvW1+IzlJSBMt29RiZpMLcBOrsSkj3JmuW+15yxvqjIKP/KxF/NWnBCXabfe49XeFqgqV7+v3
 TICTowEHS0svb0Tl+etdEznegCDRXajrEFN8b4A8bxQzZbeP73uunfbRYMcGIZs/HgD6nqTjlT4
 iRyoaGJrClls66E2NWm/ZxkluSpG+QkfgRCBhoTbYRDGvYQ47LdJ5iTzo9WiVM4h6IlgLQ9dErC
 pmthh+Nn70V1bt2wo7MyAq5ypmS4jfB0mSA/aX7gn6Cu+JnUwMk5LYT5EXUMrKiRmGuQ3E/ZSgq
 qwRjGA4u0xSMMlg8I0EVn/TzT/L/iDQhTO5YxB/DvYuv5csyT1/cSvsTZkrwKDsWW7AIBzpW0dN
 JSXIlGYBjyR80Y7b/8g==
X-Authority-Analysis: v=2.4 cv=CMknnBrD c=1 sm=1 tr=0 ts=69833adc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8
 a=THxROjQVSa7aAfmVI-MA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: qjH_PYSVtenyMtvUhDFlFo5qbAw3m6GD
X-Proofpoint-GUID: qjH_PYSVtenyMtvUhDFlFo5qbAw3m6GD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_03,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8099-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,tkos.co.il];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 93C45E5C36
X-Rspamd-Action: no action

On 2/4/26 12:25 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Describe the PWM block on IPQ9574.
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

