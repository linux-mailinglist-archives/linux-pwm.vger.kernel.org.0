Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF51EC7BC
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2020 05:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCDSE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 23:18:04 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:43316 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFCDSD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 23:18:03 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2020 23:18:02 EDT
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 022B71325;
        Wed,  3 Jun 2020 11:10:28 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.0.122] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P31254T139913132439296S1591153826661362_;
        Wed, 03 Jun 2020 11:10:27 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <57c229d03dbe2bff381c71644df05028>
X-RL-SENDER: david.wu@rock-chips.com
X-SENDER: wdc@rock-chips.com
X-LOGIN-NAME: david.wu@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH] pwm: rockchip: simplify rockchip_pwm_get_state()
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
 <20200602123914.GA3360525@ulmo>
From:   David Wu <david.wu@rock-chips.com>
Message-ID: <2f860dba-26c7-c670-58e2-9ef502881522@rock-chips.com>
Date:   Wed, 3 Jun 2020 11:10:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200602123914.GA3360525@ulmo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This change is very good, thank you. The code continues from the 
original code(get_state_v1 and get_state_v2), didn’t make any changes at 
that time, and sorry I have not seen linux-rockchip@lists.infradead.org 
mail recently.

在 2020/6/2 下午8:39, Thierry Reding 写道:
> On Thu, Sep 19, 2019 at 11:17:27AM +0200, Rasmus Villemoes wrote:
>> The way state->enabled is computed is rather convoluted and hard to
>> read - both branches of the if() actually do the exact same thing. So
>> remove the if(), and further simplify "<boolean condition> ? true :
>> false" to "<boolean condition>".
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> I stumbled on this while trying to understand how the pwm subsystem
>> works. This patch is a semantic no-op, but it's also possible that,
>> say, the first branch simply contains a "double negative" so either
>> the != should be == or the "false : true" should be "true : false".
>>
>>   drivers/pwm/pwm-rockchip.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> I've applied this. Irrespective of any feedback David would have this is
> correct and a nice simplification.
> 
> Thierry
> 


