Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00201372E10
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhEDQaP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 12:30:15 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52854 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhEDQaP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 12:30:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620145760; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=oH1tHohc/rqxGsngrqjYmA2CbkVcO2iqa+XuJaeCoJg=; b=kZuWL105XOdLZx2SBrkCnxXCkPujydTtitt8fuDar0tDIHK1sPfKdqkmYglsJzYzDIeUja/W
 Pcya8eFycTHNQ4mpZ4F+WW0toerw0rjBb48XcJdnE7j6/4MJr7EUVjx6dUvVp33nXVjRn793
 jjWrRpZDUrVuTQRdPK7wB0XUD+8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZWM1ZCIsICJsaW51eC1wd21Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 609176598166b7eff7ccf929 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 May 2021 16:29:13
 GMT
Sender: subbaram=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8F7CFC433F1; Tue,  4 May 2021 16:29:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.46.162.93] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: subbaram)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE532C4338A;
        Tue,  4 May 2021 16:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE532C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=subbaram@codeaurora.org
Subject: Re: [PATCH v7 1/6] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
References: <20210429211517.312792-1-bjorn.andersson@linaro.org>
 <20210429211517.312792-2-bjorn.andersson@linaro.org>
 <635d3f2c-d3a8-c0d6-7659-c22e44103901@codeaurora.org>
 <YJFcsRnki3XT3isk@mobian>
From:   Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Message-ID: <8e2bdc31-2259-08c6-b50c-2b464bbc86bf@codeaurora.org>
Date:   Tue, 4 May 2021 09:29:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJFcsRnki3XT3isk@mobian>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/4/21 7:39 AM, Pavel Machek wrote:
> Hi!
> On Mon 2021-05-03 18:01:09, Subbaraman Narayanamurthy wrote:
>> On 4/29/21 2:15 PM, Bjorn Andersson wrote:
>>> This adds the binding document describing the three hardware blocks
>>> related to the Light Pulse Generator found in a wide range of Qualcomm
>>> PMICs.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ...
>>> +      "^led@[0-9a-f]$":
>>> +        type: object
>>> +        $ref: common.yaml#
>>> +
>>
>> Just a question more than a comment. From what I can see, when this device is specified as a multi-color device or an individual device (e.g. "red", "green" and "blue"), the user can only set "pattern" and "repeat" under the corresponding device after setting "pattern" to "trigger". Would you be planning to add a way (e.g. another set of DT properties) for the user to specify such patterns via the devicetree itself?
>>
> Please trim your replies and format emails to 72 columns or so.

Sure noted.

> If you need patterns in DTS that can be discussed, but it should be
> generic functionality not tied to one driver.

I agree. It's not tied up just with this driver but wanted to see whether
it's feasible/acceptable.

>
> Best regards,
>
>        	    	 	     	    	      	 	 Pavel

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

