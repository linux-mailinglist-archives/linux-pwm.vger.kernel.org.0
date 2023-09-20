Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB4E7A71B7
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Sep 2023 07:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjITFAD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Sep 2023 01:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITFAD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Sep 2023 01:00:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758D395;
        Tue, 19 Sep 2023 21:59:57 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K4iWGK009386;
        Wed, 20 Sep 2023 04:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LiOWBEz6joKzNAzPxfFrxb79xYuPQg6L1gLQbvTbbZQ=;
 b=Wtadov1LIKjaoA6JWwlfaSAA/gvUkMpdQ3U/cJcRzu6AIZ4yY+4o+t88k20Tp8H0TFWy
 udbmWJAlom9wjEtAtY/FDA8wkl066LoJpY47lr5Klwj6SHVLoPWVfK1OqS/cWYjKDzID
 qfj8szFCOdMvJMgLCOFLk4Ts6iNncHaL4V9G+GkynZnGBpFgIt6/rf/yKpg337lnSZMv
 RhntY4Pb0aogYXpkdMLXNxLm5o/k1plvVnY17pZYvIgQpCbelNjx6ShfT9KvXlRM8yPE
 HVDL64IjExbw8VVXKZ/rC2kpMTRemv9nr/7OZrhLLj/gOeYq1ZUvHQkoJjgzVnTsuKX7 tA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t72pfaqtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 04:59:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K4xGF6016554
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 04:59:16 GMT
Received: from [10.216.3.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 21:59:11 -0700
Message-ID: <6721cf80-8571-7894-873c-793a05776164@quicinc.com>
Date:   Wed, 20 Sep 2023 10:28:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] pwm: driver for qualcomm ipq6018 pwm block
Content-Language: en-US
To:     Baruch Siach <baruch@tkos.co.il>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <17dd231f496d09ed8502bdd505eaa77bb6637e4b.1644226245.git.baruch@tkos.co.il>
 <8a331c88-c7d4-3a14-0ec3-fd616ea24a99@quicinc.com> <87wmwsylup.fsf@tarshish>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <87wmwsylup.fsf@tarshish>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SODvBlkJojyTfNS1svnDIPgTDguAPWzH
X-Proofpoint-ORIG-GUID: SODvBlkJojyTfNS1svnDIPgTDguAPWzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=746
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200040
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 9/15/2023 12:06 PM, Baruch Siach wrote:
>> Just curious to know if you have plans to post the next revision!
> I have been waiting for comments from pwm maintainers before sending the
> next revision.
> 
> Unfortunately since then I lost access to the hardware, so I can't test
> suggested implementation changes.  The only pending issue in v11 is the
> trivial change that Nathan Chancellor suggested, which should be safe.
> 
> If you like to take it from here you are welcome.

Sure, Thanks Baruch!

Regards,
Devi Priya
> 
> Thanks,
> baruch
> 
