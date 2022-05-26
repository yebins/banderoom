
	var locations;
	
	$(function() {
		
		$.ajax({
			type: "get",
			url: "getlocations.do",
			success: function(data) {
				locations = data;
				var addr1 = [];
				
				for (var i = 0; i < data.length ; i++) {
					addr1[i] = data[i].addr1;
				}
				
				addr1 = addr1.filter((v, i) => addr1.indexOf(v) === i);
				
				$("#addr1-loading").remove();
				
				for (var i = 0; i < addr1.length ; i++) {
					var html = "<option>" + addr1[i] + "</option>"
					$("#addr1").append(html);
				}
			}
		})
		
	})

	function showAddr2() {
		
		$("#space-list tr").css("display", "table-row");
		
		if ($("#addr1").val() == "") {
			$("#addr2").css("display", "none");
			$("#addr2").val("");
			listFilter();
			return;
		}
		
		$("#addr2").children().each(function() {
			$(this).remove();
		});

		
		$("#addr2").append("<option value=''>지역 소분류</option>")	;
		
		for (var i = 0; i < locations.length; i++) {
			if (locations[i].addr1 == $("#addr1").val()) {
				var html = "<option>" + locations[i].addr2 + "</option>";
				$("#addr2").append(html);
			}
		}
		$("#addr2").css("display", "block");

		listFilter();
		
	}
	
	function listFilter() {
		
		var addr1Filter = $("#addr1").val();
		var addr2Filter = $("#addr2").val();
		var typeFilter = $("#space-type").val();
		var statusFilter = $("#space-status").val();

		$(".spacebox").css("display", "flex");
		
		if (addr1Filter != "") {
			$("input.addr1-hidden").each(function() {
				var addr1 = $(this).val();
				if (addr1 != addr1Filter) {
					$(this).parent().css("display", "none");
				}
			})
		}
		
		if (addr2Filter != "" && addr2Filter != null && addr2Filter != undefined) {
			$("input.addr2-hidden").each(function() {
				var addr2 = $(this).val();
				if (addr2 != addr2Filter) {
					$(this).parent().css("display", "none");
				}
			})
		}
		
		if (typeFilter != "") {
			$("input.type-hidden").each(function() {
				var type = $(this).val();
				if (type != typeFilter) {
					$(this).parent().css("display", "none");
				}
			})
		}

		if (statusFilter != "") {
			$("input.status-hidden").each(function() {
				var status = $(this).val();
				if (status != statusFilter) {
					$(this).parent().css("display", "none");
				}
			})
		}
		
	}
	
	function resetFilter() {
		$("#addr1").val("");
		$("#addr2").val("");
		$("#space-type").val("");
		$("#space-status").val("");
		
		listFilter();
		
	}
	
	function mySpaceRsv(idx) {
		event.stopPropagation();
		location.href = 'myspacersv.do?idx=' + idx;
	}
	
	