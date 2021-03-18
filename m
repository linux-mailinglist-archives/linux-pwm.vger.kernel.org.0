Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BED3400A3
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Mar 2021 09:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCRIGw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Mar 2021 04:06:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:43054 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhCRIGk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 18 Mar 2021 04:06:40 -0400
IronPort-SDR: N98ixxTp0JXftw5gF2BLzf8No/Y2bYoK7hGL5RPUajNoXJ1p6mAJBbiPtmjbRMsXOP/vMG7PJa
 hNpbPbpfmQsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="253636429"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="253636429"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 01:06:39 -0700
IronPort-SDR: uWFQPdgB5uNsEqMtsvLMrWYNqwQL62cNdMdioxYVH86fDHu0wY9/t6ivZuSpA1GdmElsS4Yu9P
 /5FsA5eLMeaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="389148185"
Received: from mylly.fi.intel.com (HELO [10.237.72.57]) ([10.237.72.57])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2021 01:06:38 -0700
Subject: Re: [PATCH] pwm: dwc: Use dev_get_drvdata() directly in PM callbacks
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20210317155925.297680-1-jarkko.nikula@linux.intel.com>
 <20210317200936.zfmcpjwuvhvc2pcv@pengutronix.de>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <0343a601-466f-ad52-cd1c-cb443482018f@linux.intel.com>
Date:   Thu, 18 Mar 2021 10:06:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317200936.zfmcpjwuvhvc2pcv@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 3/17/21 10:09 PM, Uwe Kleine-König wrote:
> Hello Jarkko,
> 
> On Wed, Mar 17, 2021 at 05:59:25PM +0200, Jarkko Nikula wrote:
>> Instead of figuring out struct pci_dev pointer from device pointer and
>> then pci_get_drvdata() we can use directly dev_get_drvdata() to get the
>> pointer to struct dwc_pwm.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> ---
>>   drivers/pwm/pwm-dwc.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
>> index f6c98e0d57c2..4d59a035c0c9 100644
>> --- a/drivers/pwm/pwm-dwc.c
>> +++ b/drivers/pwm/pwm-dwc.c
>> @@ -258,8 +258,7 @@ static void dwc_pwm_remove(struct pci_dev *pci)
>>   #ifdef CONFIG_PM_SLEEP
>>   static int dwc_pwm_suspend(struct device *dev)
>>   {
>> -	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>> -	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
>> +	struct dwc_pwm *dwc = dev_get_drvdata(dev);
>>   	int i;
> 
> I'm a bit ambivalent here. I'd consider it an implementation detail of
> the PCI framework that pci_get_drvdata is dev_get_drvdata on the related
> struct device. So even though the PCI guys probably will never change
> that, it feels a bit like a layer violation to rely on this behaviour.
> 
> As additionally the status quo isn't less effective (unless I miss
> something) than the alternative proposed in your patch, I tend to not
> like your change.
> 
Yeah, agree, it is a bit confusing to see mix of pci_set_drvdata() and 
dev_get_drvdata(). Got the idea for this patch from another driver and 
similar commits.

Better would be to switch entirely to dev_set_drvdata() in probe and 
dev_get_drvdata() in all other functions. Perhaps not worth of effort 
(does here 4 insertions(+), 6 deletions(-)) and not many PCI drivers 
seem to use dev_set_drvdata() in their probe (additional confusion?).

Jarkko
